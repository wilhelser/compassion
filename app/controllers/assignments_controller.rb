class AssignmentsController < InheritedResources::Base
  respond_to :js
  before_filter :authenticate_adjuster!

  def accept
    @assignment = Assignment.find(params[:id])
    @adjuster = @assignment.adjuster
    @assignments = @adjuster.assignments
    @assignment.accept
    respond_with @assignment
  end

  def decline
    @assignment = Assignment.find(params[:id])
    @assignment.create_new_assignment
  end

end
