class DonationsController < InheritedResources::Base
  respond_to :html, :js, :json

  def create
    @donation = Donation.new(params[:donation])

    if @donation.save_with_payment
      respond_with @donation, :status => 200
    else
      render :json => @donation.errors, :status => :unprocessable_entity
    end
  end
end
