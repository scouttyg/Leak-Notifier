class FeedEntry < ActiveRecord::Base
  attr_accessible :guid, :name, :published_at, :summary, :url

  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
  end
  
  def self.update_from_feed_continuously(feed_url, delay_interval = 15.minutes)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
    loop do
      sleep delay_interval
      feed = Feedzirra::Feed.update(feed)
      add_entries(feed.new_entries) if feed.updated?
    end
  end
  
  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name => entry.title,
          :summary => entry.summary.strip,
          :url => entry.url,
          :published_at => entry.published,
          :guid => entry.id
        )
        add_leaks(entry)
      end
    end
  end
  def self.add_leaks(entry)
    final_array = entry.title.gsub(/[^a-zA-Z\s\.-]/, '').downcase.split
    all_service_names = (Service.select("name")).collect{|each| each.name}
    all_urls = (Service.select("url")).collect{|each| each.url}
    final_array.each do |word|
      name_leak = false
      url_leak = false
      if all_service_names.include?(word) 
        name_leak = true
      elsif all_urls.include?(word)
        url_leak = true
      end
      if name_leak == true
        service_id = Service.find_by_name(word).id
        service_name = Service.find_by_name(word).url
      elsif url_leak == true
        service_id = Service.find_by_url(word).id
        service_name = word
      end
      last_leak = Leak.find_by_service_name(service_name)
      if last_leak.nil? or last_leak.first_reported < 2.months.ago
        if !service_name.blank? and service_name.present?
          Rails.logger.info service_name
          Leak.create!(
            :service_name => service_name ,
            :service_id => service_id,
            :first_reported => entry.published,
            :feed_entry_id => FeedEntry.find_by_guid(entry.id).id
          )
          @new_leak = Leak.find_by_service_name(service_name)
          contact_users(@new_leak)
        end
      end
    end
  end
  
  def self.contact_users(new_leak)
    @leak = new_leak
    @users_to_contact = Service.find(@leak.service_id).users
    if @users_to_contact.present?
      @users_to_contact.each do |user|
        LeakMailer.leak_alert(user, @leak).deliver
        Rails.logger.info "I have contacted a user, David."
      end
    end
  end
end
