class CustomersTestDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
   @view = view
  end

  def as_json(options = {})
   {
     aEcho: params[:sEcho].to_i,
      iTotalRecords: "<%= @business.customers.count %>",
      iTotalDisplayRecords: customers.total_entries,
     aaData: data
   }
  end

  private
   def data
      customers.map do |customer|
       [
         link_to(customer.first_name, customer),
          (customer.last_name),
          (customer.email),
          (customer.phones.first.number),
          (customer.visits.count)


       ]
     end
   end
   
   def customers
     @customers ||= fetch_customers
   end
  
    def fetch_customers
     customers = Business.first.customers.order("#{sort_column} #{sort_direction}")
     customers = customers.page(page).per_page(per_page)
        if params[:sSearch].present?
          customers = customers.where("first_name like :search or last_name like :search", search: "%#{params[:sSearch]}%")
        end
      customers
    end
    
   def page
    params[:iDisplayStart].to_i/per_page + 1
  end
    
    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[first_name last_name]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
    
end