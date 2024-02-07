require "rails_helper"

RSpec.describe Item, type: :model do
  let(:metadata) { '{"foo": "bar"}' }
  let(:item) { build :item, metadata: }

  describe "#metadata" do
    it "is saved as serialized JSON" do
      item.save!
      expect(item.reload.metadata).to be_a(Hash)
    end

    context "with blank input" do
      let(:metadata) { "" }

      it "makes the item invalid" do
        expect(item.valid?).to be(false)
        expect(item.errors[:metadata]).to be_present
      end
    end

    context "with invalid JSON" do
      let(:metadata) { "invalid" }

      it "makes the item invalid" do
        expect(item.valid?).to be(false)
        expect(item.errors[:metadata]).to be_present
      end
    end
  end
end
