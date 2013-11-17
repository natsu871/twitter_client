require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    admin = User.create!(:name => "Admin",
                         :email => "admin@example.com",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)

    User.create!(:name => "Username",
                 :email => "abc@example.com",
                 :password => "foobar",
                 :password_confirmation => "foobar")

    99.times do |n|
      name = Faker::Name.first_name
      email = "abc-#{n+1}@example.com"
      password = "password"

      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end
