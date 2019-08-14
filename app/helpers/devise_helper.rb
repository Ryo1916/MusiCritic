module DeviseHelper
  def devise_error_messages!(resource: resource())
    return "" unless devise_error_messages?(resource: resource)

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="error_field alert alert-danger" role="alert">
      <ul class="error_msg">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?(resource: resource())
    !resource.errors.empty?
  end

end
