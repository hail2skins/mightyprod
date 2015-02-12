class CustomerBulkMailer < ApplicationMailer
  default from: 'support@hamcois.com'
  
  def bulk_email(customer, notification)
    @customer = customer
    @notification = notification
    
    mail(to: @customer.email, subject: @notification.subject)
  end
end
