require "rails_helper"

RSpec.describe DescriptionForm, type: :model do
  let(:item) { build :item, name: nil, metadata: {} }
  let(:description) { Faker::Lorem.paragraph }
  let(:params) do
    { item: { description: } }
  end
  let(:title_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the description to metadata" do
      title_form.save
      expect(item.reload.metadata["description"]).to eq(description)
    end

    context "when description blank" do
      let(:description) { "" }

      it "invalidates form" do
        expect(title_form).to be_invalid
      end
    end
  end
end
