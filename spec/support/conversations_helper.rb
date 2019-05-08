
def send_message(subject, body)
  within('form#new_message') do
    fill_in 'message[subject]', with: subject
    fill_in 'message[body]', with: subject
  end

  click_button 'send-message-btn'
end
