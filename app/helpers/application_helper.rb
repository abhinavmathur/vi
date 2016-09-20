module ApplicationHelper
  def active_page(page)
    if page == current_page?
      return 'active'
    end
  end
end
