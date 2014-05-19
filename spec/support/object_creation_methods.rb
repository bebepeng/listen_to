def create_valid_user
  User.create!(:email => 'bebe@email.com', :username => 'Bebe', :password => 'password')
end

def create_another_valid_user
  User.create!(:email => 'bob@email.com', :username => 'Bob', :password => 'password')
end