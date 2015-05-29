# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
newadmin = Admin.new({:email => 'arifgoemleksiz101@gmail.com', :password=> 'qwe123qwe',:password_confirmation => 'qwe123qwe'})

newadmin.save
newuser = User.new({:name=> 'ataraxie67', :email => 'arifgoemleksiz101@gmail.com', :password=> 'qwe123qwe',:password_confirmation => 'qwe123qwe'})

newuser.save
newuser1 = User.new({:name=> 'ataraxie68', :email => 'arifgoemleksiz102@gmail.com', :password=> 'qwe123qwe',:password_confirmation => 'qwe123qwe'})

newuser1.save
newuser2 = User.new({:name=> 'ataraxie69', :email => 'arifgoemleksiz103@gmail.com', :password=> 'qwe123qwe',:password_confirmation => 'qwe123qwe'})

newuser2.save
newuser3 = User.new({:name=> 'ataraxie70', :email => 'arifgoemleksiz104@gmail.com', :password=> 'qwe123qwe',:password_confirmation => 'qwe123qwe'})

newuser3.save
