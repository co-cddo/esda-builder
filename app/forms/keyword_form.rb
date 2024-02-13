class KeywordForm < BaseForm
  def update_item
    item.metadata["keyword"] = keyword
  end

  def keyword
    @keyword ||= params.dig(:item, :keyword).split(/\s*,\s*/)
  end
end
