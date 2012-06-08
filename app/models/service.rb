class Service < ActiveRecord::Base
  attr_accessible :name, :reset_url, :url, :users
  has_and_belongs_to_many :users, :join_table => "services_users"
end
