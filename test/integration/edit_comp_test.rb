require "test_helper"

class EditCompTest < ActionDispatch::IntegrationTest
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
  
  test "from business profile page edit non-comp visit so it is a comp visit" do
    click_link "Total Customer Visits: #{business.visits.count}"
    click_link first_visit_rose.visit_notes
    
    #assure it does not appear as a comp visit by refuting comp visit stuff
    refute page.has_content?("Normal Total:"), "Refute Content -- Normal Total should not exist but does."
    refute page.has_content?("Discount Amount:"), "Refute Content -- Discount Amount should not exist but does."
    
    click_link "Edit this visit"
    check_content "Did you discount this visit?",
                  "If so, check the box below and type in the total amount you charged for this visit.",
                  "As an example, if you normally charge $100.00 for a service, but only charged this customer $75.00, check the box and type in $75.00.",
                  "When you click the Create Visit button, we'll do the math for you.",
                  "Check this ONLY if you wish to give a discount",
                  "Total charged for this visit?"
                  
    assert page.has_no_checked_field?("Check this ONLY if you wish to give a discount"), "Field -- Check this ONLY if you wish to give a discount is checked."
    
    find_field "Total charged for this visit?" 
    
    check "Check this ONLY if you wish to give a discount"
    
    fill_in "Total charged for this visit?", with: "25"
    
    click_button "Update Visit"
    
    click_link "Total Customer Visits: #{business.visits.count}"
    click_link first_visit_rose.visit_notes
    
    #new content now
    check_content "Normal Total: $75.00",
                  "Discount Amount: $50.00",
                  "Visit Amount: $25.00"
                  
    end
    
    test "from customer profile page edit comp visit so it is a non-comp visit" do
      click_link "Rose"
      click_link "$#{comp_rose.amount_comp.to_i}.00"
      click_link "$#{comp_rose.amount_comp.to_i}.00"
      
      #confirm it's a comp, which we know it is
      check_content "Normal Total",
                    "Discount Amount"
                    
      click_link "Edit this visit"
      uncheck "Check this ONLY if you wish to give a discount"
      click_button "Update Visit"
      
      click_link "Rose"
      #no more discount with this content
      check_content "Total Amount Discounted: $0.00"
   end
   
   test "from customer profile page edit amount of an existing comp" do
     click_link "Kathy"
     click_link "$#{kathy.comps.sum(:amount_comp).to_i}.00"
     click_link "$#{comp_kathy_one.amount_comp.to_i}.00"
     
     #confirm amount is right
     check_content "Visit Amount: $150.00",
                   "Discount Amount: $#{comp_kathy_one.amount_comp.to_i}.00"
                   
    click_link "Edit this visit"
    
    fill_in "Total charged for this visit?", with: "100"
    click_button "Update Visit"
    
    click_link "Kathy"
    click_link "$175.00"
    
    click_link "$100.00"
    
    #confirm new totals
    check_content "Discount Amount: $100.00",
                  "Visit Amount: $100.00"
  end
  
  test "fail to edit a comp leaving total amount blank" do
    click_link "Rose"
    click_link "$100.00"
    click_link "$100.00"
    click_link "Edit this visit"
    
    fill_in "Total charged for this visit?", with: ""
    click_button "Update Visit"
    #here's your content
    check_content "Visit successfully edited.",
                  "You checked the box but did not enter the total visit amount.  No discount created on this visit."
  end
  
  test "fail to edit a comp putting way too much in for total amount" do
    click_link "Rose"
    click_link "$100.00"
    click_link "$100.00"
    click_link "Edit this visit"
    
    fill_in "Total charged for this visit?", with: "7000"
    click_button "Update Visit"
    #here's your content
    check_content "Visit successfully edited.", 
                  "You entered more for the discount than the visit cost.   No discounted created."
  end
    
    
end
