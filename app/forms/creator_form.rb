class CreatorForm < BaseForm
  validates :creator, presence: true

  def update_item
    item.metadata["creator"] = creator
  end

  def creator
    @creator ||= params.dig(:item, :creator)
  end
end
