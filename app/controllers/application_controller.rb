class ApplicationController < ActionController::Base
  add_flash_types :error

  around_action :set_time_zone

  protected

  def success_message(object_klass, key)
    handler = ResourcesLocalesHandler.new(object_klass)
    handler.success_message(key)    
  end

  def set_time_zone(&block)
    Time.use_zone(timezone_from_cookies, &block)
  end

  def timezone_from_cookies
    cookies.fetch(:timezone, 'Etc/UTC')
  end
end
