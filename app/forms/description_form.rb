class DescriptionForm < BaseForm
  validates :description, presence: true

  def update_item
    item.metadata["description"] = description
  end

  def description
    @description ||= params.dig :item, :description
  end
end
