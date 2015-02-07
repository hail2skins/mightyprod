class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Devise requires this for strong parameters like behavior for additions to the model
  before_filter :configure_permitted_parameters, if: :devise_controller?

  #Cancancan override to make owner permissions rather than user
  def current_ability
  	@current_ability ||= Ability.new(current_owner)
  end

  #supplied method by device
  def after_sign_in_path_for(resource)
  	if current_owner.businesses.count == 1 then
  		@business = current_owner.businesses.first
  		owner_business_path(current_owner, @business)
  	else
  		current_owner
  	end
	end


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end


  protected

			def configure_permitted_parameters
				devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email,
																																:password,
																																:password_confirmation,
																																:first_name,
																																:last_name,
																																:middle_name,
																																:admin) }

				devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email,
																																:password,
																																:password_confirmation,
																																:current_password,
																																:first_name,
																																:last_name,
																																:middle_name,
																																:admin) }
			end
end
