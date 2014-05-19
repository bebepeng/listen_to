module FeatureHelpers
  def login(user)
    visit '/'
    click_on 'Log In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => 'password'
    click_on 'Log In'
  end
end