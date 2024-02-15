class IdentifierForm < BaseForm
  validates :identifier, presence: true

  def update_item
    item.metadata["identifier"] = identifier
  end

  def identifier
    @identifier ||= from_params(:identifier)
  end
end
