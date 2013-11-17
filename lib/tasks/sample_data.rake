require 'faker'

namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		make_users
		make_microposts
		make_relationships
	end
end

def make_users
	admin = User.create!(:name => "Admin",
											 :email => "admin@example.com",
											 :password => "foobar",
											 :password_confirmation => "foobar")
	admin.toggle!(:admin)

	99.times do |n|
		name = Faker::Name.first_name
		email = "abc-#{n+1}@example.com"
		password = "password"

		User.create!(:name => name,
								 :email => email,
								 :password => password,
								 :password_confirmation => password)
	end
end

def make_microposts
	User.all(:limit => 6).each do |user|
		50.times do
			user.microposts.create!(:content => Faker::Lorem.sentence(5))
		end
	end
end

def make_relationships
	users = User.all
	user  = users.first
	following = users[1..50]
	followers = users[3..40]
	following.each { |followed| user.follow!(followed) }
	following.each { |follower| follower.follow!(user) }
end