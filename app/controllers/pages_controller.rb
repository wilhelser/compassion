class PagesController < InheritedResources::Base
  def show
    @page = Page.find(params[:id])
    @page_title = @page.title
  end
end
