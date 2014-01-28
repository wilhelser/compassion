class ProjectPdf < Prawn::Document
  require 'open-uri'
  def initialize(project, view)
    super(top_margin: 20, page_layout: :portrait)
    @project = project
    @view = view
    page_heading
    project_image
    project_text
    qrcode
  end

  def page_heading
    image "#{Rails.root}/public/email-logo.png"
    move_down 10
    text "#{@project.page_title}", size: 30, style: :bold, align: :center
  end

  def project_image
    move_down 10
    image open("#{@project.image_url}"), width: 300, height: 200, position: :center if @project.featured_image.present?
    image open("#{@project.key}"), width: 300, position: :center, height: 200 if @project.featured_video.present?
  end

  def project_text
    move_down 30
    text "#{@project.no_paragraph_page_message}", inline_format: true
    move_down 10
    text "To help, or for more information please visit:", size: 14, style: :bold, align: :left
    text "#{@project.long_link}", size: 14, style: :bold, align: :left
  end

  def qrcode
    move_down 20
    image open("#{@project.qrcode}"), width: 100, height: 100, align: :center
  end

end
