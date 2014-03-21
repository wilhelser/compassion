class BetaRequestsController < ApplicationController
  respond_to :html, :js

  def create
    @beta_request = BetaRequest.new(beta_request_params)

    if @beta_request.save
      respond_with @beta_request
    else
      render :json => @beta_request.errors, :status => :unprocessable_entity
    end
  end

  private
  def beta_request_params
    params.require(:beta_request).permit(:email, :name, :oops, :invited, :registered)
  end
end
