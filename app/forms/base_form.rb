class BaseForm
  include ActiveModel::Model

  attr_accessor :item, :params

  def save
    return false if invalid?

    update_item

    item.last_completed_step = template

    item.save!
  end

  def template
    self.class.to_s.underscore.delete_suffix("_form")
  end
end
