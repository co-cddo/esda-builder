require "rails_helper"

RSpec.describe RelatedResourceForm, type: :form do
  let(:item) { build :item, metadata: {} }
  let(:related_resource) { Faker::Lorem.word }
  let(:params) do
    { item: { related_resource: } }
  end
  let(:related_resource_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the related resource to metadata in an array" do
      related_resource_form.save
      expect(item.reload.metadata["relatedResource"]).to eq([related_resource])
    end

    context "when title blank" do
      let(:relatedResource) { "" }

      it "does not invalidates form" do
        expect(related_resource_form).to be_valid
      end
    end
  end
end
