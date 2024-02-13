require "rails_helper"

RSpec.describe AlternativeTitleForm, type: :form do
  let(:item) { create :item }
  let(:alternative_title) { Faker::Company.name }
  let(:params) do
    { item: { alternative_title: } }
  end
  let(:title_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the alternative title to metadata in an array" do
      title_form.save
      expect(item.reload.metadata["alternativeTitle"]).to eq([alternative_title])
    end

    context "with blank entry" do
      let(:alternative_title) { "" }

      it "saves an empty array to alternative title" do
        title_form.save
        expect(item.reload.metadata["alternativeTitle"]).to eq([])
      end
    end
  end
end
