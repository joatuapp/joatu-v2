
def sign_in_with(email, password)
  visit new_user_session_path
  within("form#new_user") do
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log In'
  end
end
