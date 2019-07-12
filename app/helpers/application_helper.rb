module ApplicationHelper
  def page_title(page_title: '')
    base_title = Constants::APP_NAME
    return base_title if page_title.blank?
    "#{page_title} | #{base_title}"
  end
end
