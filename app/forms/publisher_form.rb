class PublisherForm < BaseForm
  validates :publisher, presence: true

  def update_item
    item.metadata["publisher"] = publisher
  end

  def publisher
    @publisher ||= from_params(:publisher)
  end
end
