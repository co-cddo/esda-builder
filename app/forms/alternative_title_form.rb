class AlternativeTitleForm < BaseForm
  def update_item
    item.metadata["alternativeTitle"] = [alternative_title.presence].compact
  end

  def alternative_title
    @alternative_title ||= params.dig :item, :alternative_title
  end
end
