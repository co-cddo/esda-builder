class SummaryForm < BaseForm
  def update_item
    item.metadata["summary"] = from_params(:summary).presence
  end
end
