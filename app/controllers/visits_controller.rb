class VisitsController < ApplicationController
  before_action :get_customer_business_and_owner
  before_action :set_visit, only: [ :show, :edit, :update, :destroy ]
  after_action :comp_visit, only: [ :create, :update ]

  def index
    @visits = @customer.visits.all
  end

  def new
    @visit = @customer.visits.new
    @visit.build_comp
  end

  def show
  end

  def create
    @visit = @customer.visits.new(visit_params)

    respond_to do |format|
      if @visit.save
        find_active_deal
        update_appointment_amount
        format.html { redirect_to [@owner, @business], notice: "Visit added for " + @customer.name }
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  def edit
    @visit.build_comp if !@visit.comp
  end

  def update
    respond_to do |format|
      if @visit.update(visit_params)
        find_active_deal
        update_appointment_amount
        
        format.html { redirect_to [@owner, @business], notice: "Visit successfully edited." }
      else
        format.html { render action: 'edit' }
      end
    end
  end
  
  def destroy
    @visit.destroy
    respond_to do |format|
      format.html { redirect_to [@business, @customer], notice: 'Visit deleted.' }
    end  
  end
  

  private

      def set_visit
        @visit = @customer.visits.find(params[:id])
      end

      def visit_params
        params.require(:visit).permit(:visit_notes, :date_of_visit, :customer_id, :deal_id, :deal_visit, :service_ids=>[], :comp_attributes => [:id, :active, :amount_comp])
      end

      def get_customer_business_and_owner
        @customer = Customer.find(params[:customer_id])
        @business = @customer.business
        @owner = @business.owner
      end
      
      def find_active_deal
        if @visit.deal_visit
          visit_params.merge(service_ids: [@customer.deals.find_by(active: true).package.service_id])

          if active_deal.first.used_count >= 2
            update_visit_deal_id
            reduce_deal_used_count
            create_deal_appointment
            
          else
            update_visit_deal_id
            reduce_deal_used_count
            set_deal_completed_date
            set_deal_inactive
            create_deal_appointment
          end
        end
      end
      
      def update_appointment_amount
        @visit.appointments.each do |amount|
          if @visit.deal_visit
            amount.update_attribute(:amount, deal_amount)
          else
            service_amount = Service.find(amount.service_id)
            amount.update_attribute(:amount, service_amount.prices.first.amount)
          end
        end
      end
      
      def comp_visit
        
        if !@visit.deal_visit? 
          @comp = @visit.comp
       
          before_discount = @visit.appointments.sum :amount
          if !@comp.active
            @comp.destroy
          elsif !@comp.amount_comp
            @comp.destroy
            flash[:alert] = "You checked the box but did not enter the total visit amount.  No discount created on this visit."
          elsif @comp.amount_comp > before_discount
            @comp.destroy
            flash[:alert] = "You entered more for the discount than the visit cost.   No discounted created."
          else
            new_amount_comp = before_discount - @comp.amount_comp
            @comp.update_attributes(amount_comp: new_amount_comp, date_comp: @visit.date_of_visit, business_id: @business.id, customer_id: @customer.id)
          end
        end 
      end
      
      def update_visit_deal_id
        @visit.update_attribute(:deal_id, active_deal.first.id)
      end      
      
      def reduce_deal_used_count
        @visit.deal.decrement!(:used_count)
      end      
      
      def deal_amount
        total = @visit.deal.package.prices.first.amount / @visit.deal.package.count
        total.round(2)
      end
      
      def deal_service
        Service.find(@visit.deal.package.service_id)
      end
      
      def create_deal_appointment
        Appointment.create!(service_id: deal_service.id, visit_id: @visit.id)
      end
      
      def set_deal_completed_date
        active_deal.first.update_attribute(:date_completed, @visit.date_of_visit)
      end
      
      def set_deal_inactive
        active_deal.first.update_attribute(:active, false)
      end
      
      
end