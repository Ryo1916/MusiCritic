module ApplicationHelper
  def page_title(page_title: '')
    base_title = Constants::APP_NAME
    return base_title if page_title.blank?
    "#{page_title} | #{base_title}"
  end

  def play_icon(id:)
    content_tag(:i, '', class: "fas fa-volume-up", id: "play-#{ id }", data: { play: "playable-song", id: "#{ id }"})
  end

  def stop_icon(id:)
    content_tag(:i, '', class: "far fa-stop-circle", id: "stop-#{ id }", data: { play: "stoppable-song", id: "#{ id }"}, style: "display:none;")
  end
end
