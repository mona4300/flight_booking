module Admins::ApplicationHelper
  def activated_nav_link
    current_controller = controller.controller_name.to_sym

    mapping = Rails.configuration.navigation_map[current_controller]
    mapping || :home
  end


  def breadcrumbs(page_key, breadcrumbs_list = [])
    page = Rails.configuration.breadcrumbs[page_key]
    return breadcrumbs_list if page.nil?

    breadcrumbs_list.unshift(breadcrumb_item(page, page_key))
    breadcrumbs(page[:parent], breadcrumbs_list)
  end

  def breadcrumb_item(page, page_key)
    resources = Array(page[:keys]).map { |key| @breadcrumbs[key] }

    title = page[:type] == :resource ? "#{page[:title]} #{resources.last.name}" : page[:title]

    { title: title, url: public_send("#{page_key}_url", resources) }
  end
end
