module ApplicationHelper
  def page_title(title)
    base_title = "推しTube"
    title.empty? ? base_title : title + " | " + base_title
  end
end
