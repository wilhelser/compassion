class ContractorReviewsController < InheritedResources::Base
  respond_to :html, :js, :json

  def create
    @contractor_review = ContractorReview.create(params[:contractor_review])

    if @contractor_review.save
      respond_with @contractor_review
    else
      respond_with @contractor_review.errors.full_messages
    end
  end
end
