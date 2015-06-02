class Post < ActiveRecord::Base
	has_many :comments, as: :commentable, dependent: :destroy
	scope :recent_posts, -> {order(created_at: :desc)}
	
	belongs_to :user
	has_many :votes, as: :voteable
	validates :user_id, presence:true
	validates :avatar, presence:true
	has_attached_file :avatar, 
	:path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
	:url => "/system/:attachment/:id/:basename_:style.:extension",
	:styles => {
	  :thumb    => ['200x200#',  :jpg, :quality => 40],
	  :original    => ['100x720^',      :jpg, :quality => 70]
	  
	},
	:convert_options => {
	  :thumb    => '-set colorspace sRGB -strip',
	  :original   => '-set colorspace sRGB -strip'
	}
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	def total_votes
    	self.up_votes + self.down_votes
 	end
  
  	def up_votes
  	  self.votes.where(vote: true).size
 	end

 	def vote_score
 	  self.up_votes - self.down_votes
 	end
  	
 	def down_votes
  	  self.votes.where(vote: false).size  
 	end
end
