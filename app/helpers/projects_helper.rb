module ProjectsHelper

  def token_exists?
    session[:temp_token].blank? ? false : true
  end
end
