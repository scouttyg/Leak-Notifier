class Leak < ActiveRecord::Base
  attr_accessible :first_reported, :service_id, :service_name, :feed_entry_id
end
