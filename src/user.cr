require "crecto"
require "./repo"

class User < Crecto::Model

  schema "users", do
    field :email, String
  end
end

user = User.new
user.email = "matt@home.com"
changeset = Repo.insert(user)
puts changeset.errors
