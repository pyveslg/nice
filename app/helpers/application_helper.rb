module ApplicationHelper
  def markdown(content)
    return "" if content.blank?
    @markdown ||= (
      renderer = Redcarpet::Render::HTML.new
      Redcarpet::Markdown.new(renderer, extensions = {})
    )
    @markdown.render(content).html_safe
  end
end
