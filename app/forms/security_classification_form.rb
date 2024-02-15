class SecurityClassificationForm < BaseForm
  validates :security_classification, presence: true

  def update_item
    item.metadata["securityClassification"] = security_classification
  end

  def security_classification
    @security_classification ||= from_params(:security_classification)
  end
end
