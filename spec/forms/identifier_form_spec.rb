require "rails_helper"

RSpec.describe IdentifierForm, type: :form do
  let(:item) { build :item, metadata: {} }
  let(:identifier) { Faker::Lorem.word }
  let(:params) do
    { item: { identifier: } }
  end
  let(:identifier_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the identifier to metadata" do
      identifier_form.save
      expect(item.reload.metadata["identifier"]).to eq(identifier)
    end

    context "when title blank" do
      let(:identifier) { "" }

      it "invalidates form" do
        expect(identifier_form).to be_invalid
      end
    end
  end
end
