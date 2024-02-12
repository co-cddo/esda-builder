class SummaryForm < BaseForm
  def update_item
    item.metadata["summary"] = params.dig(:item, :summary).presence
  end
end
