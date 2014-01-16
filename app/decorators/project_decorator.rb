class ProjectDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def page_title
    model.page_title
  end

  def updates
    model.updates
  end

  def galleries
    model.galleries
  end

  def estimates
    model.estimates
  end

  def contractors
    model.nearby_contractors
  end

  def contributions
    model.contributions
  end

  def recent_contributions
    model.recent_contributions
  end

  def slug
    model.slug
  end

  def user
    model.user
  end

  def long_link
    model.long_link
  end

  def display_featured
    if model.has_video?
      model.featured_video_html
    elsif model.featured_image
      filepicker_image_tag model.featured_image, w: 758, h: 288, fit: 'crop', align: 'faces', cache: true
    end
  end

  def user_link
    link_to user.name, user_path(user)
  end

end
