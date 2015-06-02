class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.references :voteable, polymorphic: true
    	t.boolean :vote
     	t.integer :user_id
     	t.timestamps
    end
  end
end
