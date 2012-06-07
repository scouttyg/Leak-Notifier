class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :url
      t.string :reset_url

      t.timestamps
    end
  end
end
