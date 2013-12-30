class ProjectPdf < Prawn::Document
  require 'open-uri'
  def initialize(project, view)
    super(top_margin: 20, page_layout: :portrait)
    @project = project
    @view = view
    page_heading
    project_image
  end

  def page_heading
    image "#{Rails.root}/public/email-logo.png"
    move_down 10
    text "#{@project.page_title}", size: 30, style: :bold, align: :center
  end

  def project_image
    move_down 10
    image open("#{@project.image_url}"), width: 550, height: 400 unless @project.featured_image.blank?
    move_down 10
    text "#{@project.long_link}", size: 14, style: :bold, align: :center
  end

  def project_qrcode
    image open("#{@project.qrcode}"), width: 100, height: 100
  end

end
