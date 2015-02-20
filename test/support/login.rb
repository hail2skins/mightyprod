def login
    visit root_path
    
    click_link 'Login'
    
    assert_equal login_path, current_path
    
    fill_in 'Email', with: owners(:owner).email
    fill_in 'Password', with: "password"
    click_button 'Login'
    
    assert page.has_content?("Signed in successfully."), 'Signed in successfully not present.'
    #assert page.has_title?(owners(:owner).name), "Owner's name #{owners(:owner).name} not present."
end