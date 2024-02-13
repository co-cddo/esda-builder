require "rails_helper"

RSpec.describe KeywordForm, type: :form do
  let(:item) { build :item }
  let(:keyword) { Faker::Internet.slug }
  let(:params) do
    { item: { keyword: } }
  end
  let(:keyword_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the keyword to metadata in an array" do
      keyword_form.save
      expect(item.reload.metadata["keyword"]).to eq([keyword])
    end

    context "with multiple keywords" do
      let(:keywords) { [Faker::Internet.slug, Faker::Internet.slug] }
      let(:keyword) { keywords.join(", ") }

      it "saves the keywords separately in an array" do
        keyword_form.save
        expect(item.reload.metadata["keyword"]).to eq(keywords)
      end
    end
  end
end
