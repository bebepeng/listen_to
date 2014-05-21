def create_user(attributes ={})
  defaults = {
    :email => 'bebe@email.com',
    :username => 'Bebe',
    :password => 'password',
  }

  user = User.new(defaults.merge(attributes))
  user.save!
  user
end

def add_new_song(user)
  defaults = {
    :title => 'My Heart Will Go On',
    :artist => 'Celine Dion',
    :url => 'https://www.youtube.com/watch?v=DNyKDI9pn0Q',
  }

  user.songs.create!(defaults)
end