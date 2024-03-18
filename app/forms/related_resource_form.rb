class RelatedResourceForm < BaseForm
  def update_item
    item.metadata["relatedResource"] = [from_params(:related_resource)]
  end
end
