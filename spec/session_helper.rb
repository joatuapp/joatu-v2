
def sign_in_with(email, password)
  visit new_user_session_path
  within("form#new_user") do
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log In'
  end
end

def create_account_with(
  email: "test@example.com",
  password: 'password',
  first_name: 'Tester',
  last_name: 'McTester',
  pod: nil
  )
  visit new_user_registration_path
  within("form#new_user") do
    fill_in 'user_profile_attributes_given_name', with: first_name
    fill_in 'user_profile_attributes_surname', with: last_name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    check 'user_tou_agreement'
    click_button 'Sign Up'
  end
end
