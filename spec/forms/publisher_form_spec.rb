require "rails_helper"

RSpec.describe PublisherForm, type: :form do
  let(:item) { create :item }
  let(:organisation) { Organisation.all.first.id }
  let(:params) do
    { item: { publisher: organisation } }
  end
  let(:creator_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the publisher to metadata in an array" do
      creator_form.save
      expect(item.reload.metadata["publisher"]).to eq([organisation])
    end

    context "with blank entry" do
      let(:organisation) { "" }

      it "invalidates form" do
        expect(creator_form).to be_invalid
      end
    end
  end
end
