def create_valid_user(attributes ={})
  defaults = {
    :email => 'bebe@email.com',
    :username => 'Bebe',
    :password => 'password',
  }

  user = User.new(defaults.merge(attributes))
  user.save!
  user
end