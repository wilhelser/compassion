class PagesController < InheritedResources::Base
  def show
    @page = Page.friendly.find(params[:id])
    unless @page.title_override.blank?
      @page_title = @page.title_override
    else
      @page_title = @page.title
    end
  end
end
