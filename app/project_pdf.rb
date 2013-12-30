class ProjectPdf < Prawn::Document
  def initialize(project, view)
    super()
    text "This is an order invoice"
  end

end
