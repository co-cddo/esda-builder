require "rails_helper"

RSpec.describe TitleForm, type: :model do
  let(:item) { build :item, name: nil, metadata: {} }
  let(:title) { Faker::Company.name }
  let(:params) do
    { item: { title: } }
  end
  let(:title_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the title to metadata" do
      title_form.save
      expect(item.reload.metadata["title"]).to eq(title)
    end

    it "save the title to the name" do
      title_form.save
      expect(item.reload.name).to eq(title)
    end
  end
end
