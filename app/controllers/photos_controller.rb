class PhotosController < InheritedResources::Base
  respond_to :html, :js, :json

  def create
    @photo = Photo.new(params[:photo])
    @gallery = @photo.gallery

    if @photo.save
      @photos = @gallery.photos
      respond_with @photo
    else
      respond_with @photo.errors.full_messages
    end
  end
end
