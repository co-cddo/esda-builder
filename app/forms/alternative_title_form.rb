class AlternativeTitleForm < BaseForm
  def update_item
    item.metadata["alternativeTitle"] = [alternative_title.presence].compact
  end

  def alternative_title
    @alternative_title ||= from_params(:alternative_title)
  end
end
