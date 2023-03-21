module ApplicationHelper
  def crud_t(object_klass, key)
    handler = ResourcesLocalesHandler.new(object_klass)
    handler.crud(key)
  end

  def destroy_confirmation_t(object_klass, object_name)
    handler = ResourcesLocalesHandler.new(object_klass)
    handler.destroy_confirmation(object_name)
  end

  def validation_errors_t(object_klass, errors_count)
    handler = ResourcesLocalesHandler.new(object_klass)
    handler.validation_errors(errors_count)
  end
end
