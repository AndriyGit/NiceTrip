module ApplicationHelper

  def build_select_type_of_place(type)
    options = BaseObject::ALL.each_with_object({}) do |name, obj|
      obj[t(name)] = name
    end
    selected = options.select{|k,v| v == type}.values.first
    select_tag :type_of_place, options_for_select(options, selected), id: 'type_of_place', class: 'form-control'
  end
end
