class Post < ActiveRecord::Base
	has_many :comments, as: :commentable, dependent: :destroy
	scope :recent_comments, -> {order(created_at: :desc)}
	belongs_to :user
	validates :user_id, presence:true
	validates :avatar, presence:true
	has_attached_file :avatar, 
	:path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
	:url => "/system/:attachment/:id/:basename_:style.:extension",
	:styles => {
	  :thumb    => ['100x100#',  :jpg, :quality => 70],
	  :preview  => ['480x480#',  :jpg, :quality => 70],
	  :original    => ['100x720^',      :jpg, :quality => 70]
	  
	},
	:convert_options => {
	  :thumb    => '-set colorspace sRGB -strip',
	  :preview  => '-set colorspace sRGB -strip',
	  :original   => '-set colorspace sRGB -strip'
	}
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
