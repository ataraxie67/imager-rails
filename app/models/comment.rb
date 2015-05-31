class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates :user_id, presence:true
  validates :commentable_id, presence:true
  validates :commentable_type, presence:true
  scope :recent_comments, -> {order(created_at: :desc)}
end
