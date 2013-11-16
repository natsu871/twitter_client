Factory.define :user do |user|
  user.name                  "Username"
  user.email                 "foo@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end
