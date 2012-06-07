class UsersController < ApplicationController
  before_filter :authenticate_user!

  def dashboard
  	@user = current_user
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
