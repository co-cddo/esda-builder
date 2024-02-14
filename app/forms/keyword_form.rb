class KeywordForm < BaseForm
  def update_item
    item.metadata["keyword"] = keyword
  end

  def keyword
    @keyword ||= from_params(:keyword).split(/\s*,\s*/)
  end
end
