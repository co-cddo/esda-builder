require "rails_helper"

RSpec.describe SecurityClassificationForm, type: :form do
  let(:item) { build :item }
  let(:security_classification) { SecurityClassification.values.sample }
  let(:params) do
    { item: { security_classification: } }
  end
  let(:security_classification_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the security classification to metadata" do
      security_classification_form.save
      expect(item.reload.metadata["securityClassification"]).to eq(security_classification)
    end

    context "when security classification blank" do
      let(:security_classification) { "" }

      it "invalidates form" do
        expect(security_classification_form).to be_invalid
      end
    end
  end
end
