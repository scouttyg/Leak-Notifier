class CreateServicesUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :services_users, :id => false do |t|
      t.integer :service_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :services_users
  end
end