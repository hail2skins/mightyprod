require "test_helper"

class ShowCompTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    find("header").click_link("Logout")
  end
  
  def rose
    customers(:rose)
  end
  
  def kathy
    customers(:kathy)
  end
  
  def first_visit_rose
    visits(:first_visit_rose)
  end
  
  def second_visit_rose
    visits(:second_visit_rose)
  end
  
  def first_visit_kathy
    visits(:first_visit_kathy)
  end
  
  def second_visit_kathy
    visits(:second_visit_kathy)
  end
  
  def comp_rose
    comps(:rose_second_visit)
  end
  
  def comp_kathy_one
    comps(:kathy_first_visit)
  end
  
  def comp_kathy_two
    comps(:kathy_second_visit)
  end
  
  
  test "show all comps from main business page" do
    #Confirm new link to "Show"
    check_links "Comps"
    
    click_link "Comps"
    
    assert_equal comps_business_path(business), current_path, "Expected to see an index of all comps for this business but at #{current_path}."
    
    assert page.has_title?("Discounts provided for all customers"), "Title -- Discounts provided for all customers not available."
    
    #check page content for index type content
    check_content "All discounts provided",
                  "Customer Name",
                  "Date of Visit",
                  "Amount Discounted",
                  "Total Before Discount"
                  
    #confirm expected links are available
    check_links "Return to main business page",
                "$#{comp_rose.amount_comp.to_i}.00",
                "$#{comp_kathy_one.amount_comp.to_i}.00",
                "$#{comp_kathy_two.amount_comp.to_i}.00"
                
    click_link "$#{comp_rose.amount_comp.to_i}.00"
    assert_equal customer_visit_path(rose, second_visit_rose), current_path, "Expected to be at the show page for Rose's second visit but at #{current_path}."
    #check content on the visit show page to make sure comp stuff exists if there's a comp
    #this is an if statement so show_visit_test.rb has a reture to assure a non-comp visit doesn't see this
    check_content "Normal Total: $#{second_visit_rose.appointments.sum(:amount).to_i}.00",
                  "Discount Amount: $#{comp_rose.amount_comp.to_i}.00",
                  "Visit Amount: $#{second_visit_rose.appointments.sum(:amount).to_i - comp_rose.amount_comp.to_i}.00"
   
  end
  
  test "show all comps for a customer from customer show page" do
    click_link "Kathy"
    
    #assure you see the comp stuff which should now be on her page.   Need to assure this is 0 on customer_show_test.rb
    check_content "Total Amount Discounted: $#{kathy.comps.sum(:amount_comp).to_i}.00"
    
    #that content should also be a link
    check_links "$#{kathy.comps.sum(:amount_comp).to_i}.00"
    
    click_link "$#{kathy.comps.sum(:amount_comp).to_i}.00"
    assert_equal customer_comps_path(kathy), current_path, "Expected to be at Kathy's comps index but at #{current_path}."
     
    assert page.has_title?("Discounts provided for #{kathy.name}"), "Title -- Discounts provided for #{kathy.name} not available."
    #check index page content
    check_content "Discounts provided for #{kathy.name}",
                  "Date of Visit",
                  "Amount Discounted",
                  "Total Before Discount"
                  
    check_links "Return to customer profile page",
                "Return to main business page",
                "$#{comp_kathy_one.amount_comp.to_i}.00",
                "$#{comp_kathy_two.amount_comp.to_i}.00"
                
    click_link "$#{comp_kathy_one.amount_comp.to_i}.00"
    assert_equal customer_visit_path(kathy, first_visit_kathy), current_path, "Expected to be at Kathy's visit page for this visit but at #{current_path}."
                
    
  end
  
  
  
  
end
