class ReferencesController < InheritedResources::Base
  respond_to :html, :json, :js
  before_filter :authenticate_contractor!, :only => [:create]

  def create
    @contractor = current_contractor
    @reference = @contractor.references.build(params[:reference])

    if @reference.save
      respond_with @reference
    else
      respond_with @references.errors.full_messages
    end
  end
end
