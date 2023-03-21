class BreadcrumbGenerator
  attr_accessor :breadcrumbs_list

  def initialize(page_key, breadcrumbs)
    @breadcrumbs_list = []
    @breadcrumbs = breadcrumbs

    breadcrumbs(page_key)
  end

  protected

  def crud_t(object_klass, key)
    ResourcesLocalesHandler.new(object_klass).crud(key)
  end

  def breadcrumbs(page_key)
    page = Rails.configuration.breadcrumbs[page_key]
    return breadcrumbs_list if page.nil?

    self.breadcrumbs_list.unshift(breadcrumb_item(page, page_key))
    breadcrumbs(page[:parent])
  end

  def breadcrumb_item(page, page_key)
    resources = Array(page[:title][:keys]).map { |key| @breadcrumbs[key] }
    params = resources.map { |resource| resource[:id] }
    title = breadcrumb_item_title(page[:title])
    title = if page[:type] == :resource
              "#{title}: #{resources.last[:name]}"
            else
              title
            end

    { title: title, url: { helper: "#{page_key}_url", params: params } }
  end

  def breadcrumb_item_title(title)
    if title[:type] == :crud
      crud_t(title[:values][0].constantize, title[:values][1])
    elsif title[:type] == :custom
      I18n.t(title[:values][0])
    end
  end
end