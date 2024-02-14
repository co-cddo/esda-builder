class ThemeForm < BaseForm
  def update_item
    item.metadata["theme"] = theme
  end

  def theme
    @theme ||= from_params(:theme).split(/\s*,\s*/)
  end
end
