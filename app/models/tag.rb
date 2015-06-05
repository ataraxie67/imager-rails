class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :posts, through: :taggings

	def self.order_count
	  self.joins(:taggings).
	  select("tags.*, count(tag_id) as tags_count").
	  group("tag_id, tags.id").
	  order("tags_count desc").limit(10)
	
	end
end
