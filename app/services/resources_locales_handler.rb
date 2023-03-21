class ResourcesLocalesHandler
  attr_accessor :model_name

  def initialize(object_klass)
    return if object_klass.blank?

    @model_name = object_klass.model_name
  end

  def crud(key)
    if key == :show
      single
    elsif key == :index
      plural
    elsif key == :edit
      modification
    elsif key == :new
      creation
    end
  end

  def success_message(key)
    I18n.t("success.#{key}", model_name: single)
  end

  def destroy_confirmation(object_name)
    I18n.t(
      "destroy_confirmation", model_name: single.downcase, object_name: object_name
    )
  end

  def validation_errors(errors_count)
    I18n.t(
      'validation_errors', 
      error_name: errors_count > 1 ? I18n.t('error.plural') : I18n.t('error.single'),
      count: errors_count,
      model_name: single.downcase
    )
  end

  protected

  def single
    self.model_name.human(count: 1)
  end

  def plural
    self.model_name.human(count: 3)
  end

  def creation
    I18n.t('new_resource', model_name: single)
  end

  def modification
    I18n.t('edit_resource', model_name: single)
  end
end