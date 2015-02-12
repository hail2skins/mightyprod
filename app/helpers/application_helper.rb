module ApplicationHelper

#written in case apps use a SimpleForm base error.
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Mighty Smalls "
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  #helper to allow table sorting in the application
  def sortable(column, title = nil )
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to "#{title} <i class='#{direction == "desc" ? "icon-chevron-down" : "icon-chevron-up"}'></i>".html_safe, {:sort => column, :direction => direction}, {:class => css_class}
  end  
end