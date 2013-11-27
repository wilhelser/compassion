class GalleriesController < InheritedResources::Base
  respond_to :html, :json, :js

  def create
    unless params[:gallery][:project_id].blank?
      Rails.logger.info "Project id is there"
      @project = Project.find(params[:gallery][:project_id])
      @gallery = @project.galleries.build(params[:gallery])
      @galleries = @project.galleries
    else
      Rails.logger.info "We have a contractor id"
    end

    if @gallery.save
      respond_with @gallery
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
