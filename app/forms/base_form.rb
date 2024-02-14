class BaseForm
  include ActiveModel::Model

  attr_accessor :item, :params

  def save
    return false if invalid?

    update_item

    item.last_completed_step = template

    item.save!
  end

  def update_item
    # Put logic that loads data into item here in child object
    raise "this method should be overwritten in child object"
  end

  def template
    self.class.to_s.underscore.delete_suffix("_form")
  end

  def from_params(label)
    params.dig(:item, label)
  end
end
