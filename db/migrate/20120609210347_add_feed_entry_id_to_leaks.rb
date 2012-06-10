class AddFeedEntryIdToLeaks < ActiveRecord::Migration
  def change
    add_column :leaks, :feed_entry_id, :integer
  end
end
