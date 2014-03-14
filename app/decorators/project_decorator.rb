class ProjectDecorator < Draper::Decorator
  decorates :project
  # include Draper::LazyHelpers
  # delegate_all

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

  def has_estimate?
    model.has_estimate?
  end

  def featured_video
    model.featured_video
  end

  def no_paragraph_page_message
    model.no_paragraph_page_message
  end

  def qrcode
    model.qrcode
  end

  def key
    model.key
  end

  def page_message
    model.page_message.html_safe
  end

  def percent_funded
    model.percent_funded
  end

  def can_accept_donations
    model.can_accept_donations
  end

  def total_contributions
    h.number_to_currency(model.total_contributions)
  end

  def goal_amount
    h.number_to_currency(model.goal_amount)
  end

  def featured_image
    model.featured_image
  end

  def image_url
    model.image_url
  end

  def display_featured
    if model.has_video?
      model.featured_video_html
    elsif model.featured_image?
      h.filepicker_image_tag model.featured_image, w: 758, h: 288, fit: 'crop', align: 'faces', cache: true
    else
      return
    end
  end

  def user_link
    h.link_to user.name, h.user_path(user)
  end

end
