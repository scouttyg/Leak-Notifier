desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
    rssfeed = "http://news.cnet.com/8300-1009_3-83.xml"
    FeedEntry.update_from_feed(rssfeed)
end