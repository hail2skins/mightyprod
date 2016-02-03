require "test_helper"

class ShowVisitTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    find("header").click_link("Logout")
  end
  
  def visit_total
    if visit_one.comp(:amount_comp)
      visit_one.appointments.sum(:amount) - visit_one.comp.amount_comp
    else
      visit_one.appointments.sum(:amount)
    end
  end
  
  test "view a visit from main business page" do
    click_link "Total Customer Visits"
    
    assert_equal visits_business_path(business), current_path, "Expected to be at business visits index but at #{current_path}."
    
    #confirm expected content on the page from fixtures.  Only doing some.
    check_content "Art's very first visit.",
                  "Normal visit, full price.",
                  "Comp visit for Rose",
                  "Comp visit for Kathy",
                  "Another comp visit for Kathy.",
                  "Art Mills",
                  "Rose Dutton",
                  "Kathy Davis"
                  
    assert page.has_title?("Visits for #{business.name}"), "Title -- Visits for #{business.name} not available."
  
    
    #Now check normal page content expected
    check_content "Visits for #{business.name}",
                  "Return to main business page"
                  

    #check all links on page
    check_links "Return to main business page",
                "Art's very first visit.",
                "Normal visit, full price.",
                "Comp visit for Rose",
                "Comp visit for Kathy",
                "Another comp visit for Kathy."
                
    click_link "Art's very first visit."
    
    assert_equal customer_visit_path(customer, visit_one), current_path, "Expected to be at the show page for this visit, but at #{current_path}."
    
    assert page.has_title?("View visit for #{customer.name}"), "Title -- View visit for #{customer.name} not available."

    #check visit content on this page
    check_content "Visit notes: Art's very first visit.",
                  "Date of visit: #{visit_one.date_of_visit.to_date.strftime("%m/%d/%Y")}",
                  "Service(s) Provided:",
                  "First Service",
                  "Second Service",
                  "Visit Amount: $#{visit_total.to_i}.00"
                  
    #confirm links are available
    check_links "Return to customer profile page",
                "Return to main business page"
    
    #Art has no comps and won't.   So assure he doesn't see the comp related content
    refute page.has_content?("Normal Total"), "Refute Content -- Normal Total should not exist but does."
    refute page.has_content?("Discount Amount"), "Refute Content -- Discount Amount should not exist but does."
                  
  end

  test "check visit from customer show page" do
    click_link "Art"
    
    #Confirm content expected is here
    check_content "Last Visit: #{visit_one.date_of_visit.to_date.strftime("%m/%d/%Y")}",
                  "Total Visits: #{customer.visits.count}",
                  "Amount Spent: $#{customer.appointments.sum(:amount).to_i - customer.comps.sum(:amount_comp).to_i}.00"
                  
    #check all links
    check_links "Return to main business page",
                "New visit for #{customer.name}",
                "#{visit_one.date_of_visit.to_date.strftime("%m/%d/%Y")}",
                "Total Visits:",
                "My Visit History"
                
    #check visit page from date of visit link
    click_link visit_one.date_of_visit.to_date.strftime("%m/%d/%Y")
    
    assert_equal customer_visit_path(customer, visit_one), current_path, "Expected to be at the visit for this customer, but at #{current_path}."

    click_link "Return to customer profile page"

    #now check index from My Visit History button
    click_link "My Visit History"
    
    assert_equal customer_visits_path(customer), current_path, "Expected to be at index for customer visits but at #{current_path}."
    
    assert page.has_title?("Visit history for #{customer.name}"), "Title -- Visit history for #{customer.name} not available."
    
    click_link "Show", match: :first
   
    assert_equal customer_visit_path(customer, visit_one), current_path, "Expected to be at the show page for this visit, but at #{current_path}."
    
    click_link "Return to customer profile page"

    
    #now check index availability from total visit count link
    click_link "Total Visits:"

    assert_equal customer_visits_path(customer), current_path, "Expected to be at index for customer visits but at #{current_path}."
  end

end
