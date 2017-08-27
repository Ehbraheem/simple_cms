class SectionsController < ApplicationController

  before_action :confirm_logged_in
  before_action :set_section, only: [:show, :update, :delete, :destroy, :edit]

  def index
    @sections = Section.all
  end

  def show
  end

  def new
    @section = Section.new
    @section_count = Section.count + 1
    @pages = Page.sorted
  end

  def create
    @section = Section.new section_params
    if @section.save
      flash[:notice] = "Section created successfully"
      redirect_to sections_path
    else
      @section_count = Section.count + 1
      @pages = Page.sorted
      render 'new'
    end
  end

  def edit
    @section_count = Section.count
    @pages = Page.sorted
  end

  def update
    if @section.update_attributes section_params
      flash[:notice] = "Section updated successfully"
      redirect_to section_path @section
    else
      @section_count = Section.count
      @pages = Page.sorted
      render 'edit'
    end
  end

  def delete
  end

  def destroy
    @section.destroy
    flash[:notice] = "Section #{@section.name} destroyed successfully."

    redirect_to sections_path
  end

  private 

  def set_section
    @section = Section.find params[:id]
  end

  def section_params
    params.require(:section).(:page_id, :name, :position, :visible, :content, :content_type)
  end

end
