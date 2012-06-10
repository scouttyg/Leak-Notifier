class CreateLeaks < ActiveRecord::Migration
  def change
    create_table :leaks do |t|
      t.string :service_name
      t.integer :service_id
      t.datetime :first_reported

      t.timestamps
    end
  end
end
