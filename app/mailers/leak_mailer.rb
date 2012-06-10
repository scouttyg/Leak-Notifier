class LeakMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def leak_alert(user, leak)
    @user = user
    @leak = leak
    @service  = Service.find(@leak.service_id)
    @news = FeedEntry.find(@leak.feed_entry_id)
    mail(:to => user.email, :subject => "Potential Password Leak: #{@service.url}")
  end
end
