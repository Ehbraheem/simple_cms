class PagesController < ApplicationController

  before_action :confirm_logged_in
  before_action :set_page, only: [:show, :update, :delete, :destroy, :edit]
  before_action :find_subjects, only: [:new, :create, :edit, :update]
  before_action :set_page_count, only: [:new, :create, :edit, :update]

  def index
    @pages = Page.sorted
  end

  def show
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new page_params
    if @page.save
      flash[:notice] = "Page created successfully"
      redirect_to pages_path
    else
      render 'new'
    end
  end

  def edit
    @subjects = Subject.sorted
  end

  def update
    if @page.update_attributes page_params
      flash[:notice] = "Page updated successfully"
      redirect_to page_path @page
    else
      render 'edit'
    end
  end

  def delete
  end

  def destroy
    @page.destroy
    flash[:notice] = "Page #{@page.name} destroyed successfully."

    redirect_to pages_path
  end

  private 

  def set_page
    @page = Page.find params[:id]
  end

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end

  def find_subjects
    @subjects = Subject.sorted
  end

  def set_page_count
    @page_count = Page.count
    if params[:action] == 'new' || params[:action] == 'create'
      @page_count += 1
    end
  end
end
