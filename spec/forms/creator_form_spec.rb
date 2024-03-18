require "rails_helper"

RSpec.describe CreatorForm, type: :form do
  let(:item) { create :item }
  let(:organisation) { Organisation.all.first.id }
  let(:params) do
    { item: { creator: organisation } }
  end
  let(:creator_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the creator to metadata in an array" do
      creator_form.save
      expect(item.reload.metadata["creator"]).to eq([organisation])
    end

    context "with blank entry" do
      let(:organisation) { "" }

      it "invalidates form" do
        expect(creator_form).to be_invalid
      end
    end
  end
end
