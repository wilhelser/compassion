class ContractorSelectionsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js, :json

  def create
    @project = Project.find(params[:project_id])
    @contractor = Contractor.find(params[:contractor_id])
    @contractor_selection = ContractorSelection.create(:project_id => @project.id, :contractor_id => @contractor.id)

    if @project.contractors.size > 0
      respond_with "You can only have one contractor dipshit!"
    else
      if @contractor_selection.save
        respond_with @contractor
      else
        respond_with @contractor_selection.errors.full_messages
      end
    end
  end
end
