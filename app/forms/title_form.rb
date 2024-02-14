class TitleForm < BaseForm
  validates :title, presence: true

  def update_item
    item.name = title
    item.metadata["title"] = title
  end

  def title
    @title ||= from_params(:title)
  end
end
