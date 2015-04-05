module BaseObjectsHelper
  def object_type_for_url(type)
    type.underscore.pluralize
  end
end
