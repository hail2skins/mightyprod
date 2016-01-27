def login
  visit login_path
    
    fill_in 'Email', with: owners(:owner).email
    fill_in 'Password', with: "password"
    click_button 'Login'
end

def new_login
  visit login_path
    
    fill_in 'Email', with: owners(:login_owner).email
    fill_in 'Password', with: "password"
    click_button 'Login'
end

def service_test_login
  visit login_path
    
    fill_in 'Email', with: owners(:service_test_owner).email
    fill_in 'Password', with: "password"
    click_button 'Login'
end