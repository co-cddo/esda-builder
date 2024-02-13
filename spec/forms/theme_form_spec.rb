require "rails_helper"

RSpec.describe ThemeForm, type: :form do
  let(:item) { create :item }
  let(:theme) { Faker::Lorem.word }
  let(:params) do
    { item: { theme: } }
  end
  let(:theme_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the theme to metadata in an array" do
      theme_form.save
      expect(item.reload.metadata["theme"]).to eq([theme])
    end

    context "with blank entry" do
      let(:theme) { "" }

      it "saves an empty array to alternative title" do
        theme_form.save
        expect(item.reload.metadata["theme"]).to eq([])
      end
    end

    context "with multiple keywords" do
      let(:themes) { [Faker::Lorem.word, Faker::Lorem.word] }
      let(:theme) { themes.join(", ") }

      it "saves the themes separately in an array" do
        theme_form.save
        expect(item.reload.metadata["theme"]).to eq(themes)
      end
    end
  end
end
