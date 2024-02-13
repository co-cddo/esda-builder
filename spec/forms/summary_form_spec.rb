require "rails_helper"

RSpec.describe SummaryForm, type: :form do
  let(:item) { create :item }
  let(:summary) { Faker::Lorem.paragraph }
  let(:params) do
    { item: { summary: } }
  end
  let(:summary_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the summary to metadata" do
      summary_form.save
      expect(item.reload.metadata["summary"]).to eq(summary)
    end

    context "with blank entry" do
      let(:summary) { "" }

      it "saves an empty array to alternative title" do
        summary_form.save
        expect(item.reload.metadata["summary"]).to be_nil
      end
    end
  end
end
