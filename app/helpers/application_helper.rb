module ApplicationHelper
  def page_title
    base_title = Constants::APP_NAME
    return base_title if @title.blank?
    "#{base_title} | #{@title}"
  end
end
