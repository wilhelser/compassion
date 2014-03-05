class GalleriesController < InheritedResources::Base
  respond_to :html, :json, :js

  def index
    if params[:contractor_id].present?
      @contractor = Contractor.find(params[:contractor_id])
      @galleries = @contractor.galleries
      @contractor_gallery = true
      @page_title = "Galleries - #{@contractor.name}"
    elsif params[:project_id].present?
      @project = Project.find(params[:project_id])
      @galleries = @project.galleries
      @project_gallery = true
    end
  end

  def create
    if params[:gallery][:gallery_type] == "project"
      @project_gallery = true
      @project = Project.find(params[:gallery][:project_id])
      @gallery = Gallery.new(params[:gallery])
      @galleries = @project.galleries
    else
      @contractor_gallery = true
      @contractor = Contractor.find(params[:gallery][:contractor_id])
      @gallery = Gallery.new(params[:gallery])
      @galleries = @contractor.galleries
    end

    if @gallery.save
      if @contractor_gallery = true
        redirect_to edit_contractor_gallery_path(@contractor, @gallery)
      else
        redirect_to edit_project_gallery_path(@project, @gallery)
      end
    else
      respond_with @gallery.errors.full_messages
    end
  end

  def show
    @gallery = Gallery.find(params[:id])
    @page_title = @gallery.title
    @photos = @gallery.photos
  end

  def edit
    @gallery = Gallery.find(params[:id])
    @page_title = "#{@gallery.title} - Edit"
    @photos = @gallery.photos
  end
end
