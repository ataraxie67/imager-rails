# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
newadmin = Admin.new({:email => 'admin@g.de', :password=> 'qwe123qwe',:password_confirmation => 'qwe123qwe'})

newadmin.save

(0..50).each do |i|
	user_index=i
	User.create({:name=> "user#{user_index}", :email => "user#{user_index}@g.de", 
		:password=> 'qwe123qwe',:password_confirmation => 'qwe123qwe'})
end