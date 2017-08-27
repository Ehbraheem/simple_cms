class AdminUsersController < ApplicationController

  before_action :confirm_logged_in
  before_action :set_admin_user, only: [:update, :edit, :delete, :destroy]

  def index
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new admin_user_params
    if @admin_user.save
      flash[:notice] = 'Admin user created successfully.'
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @admin_user.update_attributes admin_user_params
      flash[:notice] = 'Admin user updated successfully.'
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def delete
  end

  def destroy
    @admin_user.destroy
    flash[:notice] = "Admin user destroyed successfully."
    redirect_to admin_users_path
  end


  private

  def admin_user_params
    params.require(:admin_user).permit(
      :first_name,
      :last_name,
      :email,
      :username,
      :password)
  end

  def set_admin_user
    @admin_user = AdminUser.find params[:id]
  end

end
