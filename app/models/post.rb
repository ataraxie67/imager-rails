class Post < ActiveRecord::Base
	has_many :comments, as: :commentable, dependent: :destroy
	has_many :taggings
	has_many :tags, through: :taggings

	scope :recent_posts, -> {order(created_at: :desc)}
	scope :upvoted_posts, ->{order(upvote_count: :desc)}
	scope :commented_posts, ->{order(comments_count: :desc)}
	scope :viewed_posts, ->{order(impressions_count: :desc)}
	
	scope :last_month, ->{where(created_at: 1.months.ago..DateTime.now)}
	scope :last_week, ->{where(created_at: 1.weeks.ago..DateTime.now)}
	scope :last_day, ->{where(created_at: 1.days.ago..DateTime.now)}
	scope :last_hour, ->{where(created_at: 1.hours.ago..DateTime.now)}

	is_impressionable :counter_cache => true, :unique => :user_id
	belongs_to :user
	has_many :votes, as: :voteable
	validates :user_id, presence:true
	validates :avatar, presence:true
	has_attached_file :avatar, 
	:path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
	:url => "/system/:attachment/:id/:basename_:style.:extension",
	:styles => {
	  :thumb    => ['200x200#',  :jpg],
	  :original    => ['100x1080^',      :jpg]
	  
	},
	:convert_options => {
	  :thumb    => '-set colorspace sRGB -strip -quality 80',
	  :original   => '-set colorspace sRGB -strip -quality 60'
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

 	def all_tags=(names)
	  self.tags = names.split(",").map do |name|
	      Tag.where(name: name.strip).first_or_create!
	  end
	end
 
	def all_tags
	  self.tags.map(&:name).join(", ")
	end

	def self.tagged_with(name)
		begin
		  Tag.find_by_name!(name).posts
		rescue
		  return nil
		end
	end
end
