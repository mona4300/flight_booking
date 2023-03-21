module Admins::ApplicationHelper
  def activated_nav_link
    current_controller = controller.controller_name.to_sym

    mapping = Rails.configuration.navigation_map[current_controller]
    mapping || :home
  end

  def breadcrumbs(page_key)
    BreadcrumbGenerator.new(page_key, @breadcrumbs).breadcrumbs_list
  end
end
