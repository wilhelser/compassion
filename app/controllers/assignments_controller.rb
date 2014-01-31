class AssignmentsController < InheritedResources::Base
  respond_to :js
  before_filter :authenticate_adjuster!

end
