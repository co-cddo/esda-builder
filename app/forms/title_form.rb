class TitleForm
  include ActiveModel::Model

  attr_accessor :item, :params

  validates :title, presence: true

  def save
    return false if invalid?

    item.name = title
    item.metadata["title"] = title
    item.save!
  end

  def title
    @title ||= params.dig :item, :title
  end
end
