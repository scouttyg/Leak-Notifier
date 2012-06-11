class UsersController < ApplicationController
  before_filter :authenticate_user!

  def dashboard
  	@user = current_user
  	all_user_services = current_user.services
  	all_leaks = Leak.all
  	user_leaks = []
    all_leaks.each do |leak|
      possible = all_user_services.find_by_url(leak.service_name)
      if possible.present?
        user_leaks.push possible
      end 
	  end
	  @leaks = user_leaks
  end

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
  	if current_user.id.to_s == params[:id]
    	@user = User.find(params[:id])
    else
    	flash[:error] = 'Not authorized as an administrator.'
    	redirect_to root_path
    end
  end

end
