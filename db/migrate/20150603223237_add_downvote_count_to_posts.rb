class AddDownvoteCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :downvote_count, :integer, default: 0
  end
end
