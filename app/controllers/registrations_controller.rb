Class RegistrationsController::DeviseController

  def new
    if params[:access_code].empty?
      redirect_to :root
    elsif params[:access_code] != 'balls'
      redirect_to :root
    else
      super
    end
  end
end
