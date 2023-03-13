module Admins
  class ApplicationController < ::ApplicationController
    before_action :authenticate_admin!, :init_breadcrumbs

    layout 'admins/application'

    protected

    def init_breadcrumbs
      @breadcrumbs = {}
    end
  end
end
