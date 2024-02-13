class ThemeForm < BaseForm
  def update_item
    item.metadata["theme"] = theme
  end

  def theme
    @theme ||= params.dig(:item, :theme).split(/\s*,\s*/)
  end
end
