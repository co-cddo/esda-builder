class DescriptionForm < BaseForm
  validates :description, presence: true

  def update_item
    item.metadata["description"] = description
  end

  def description
    @description ||= from_params(:description)
  end
end
