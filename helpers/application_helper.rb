module ApplicationHelper
  def title(value = nil)
    @title = value if value
    "#{ENV['title']}#{@title ? (' - ' + @title) : ''}"
  end
end
