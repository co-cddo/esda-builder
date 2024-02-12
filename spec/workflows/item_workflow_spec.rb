require "rails_helper"

RSpec.describe ItemWorkflow, type: :workflow do
  subject(:item_workflow) { described_class.new(item:, params:) }
  let(:steps) { described_class::STEPS }
  let(:item) { create :item }
  let(:params) { { foo: :bar } }

  describe ".form_for" do
    let(:form) { described_class.form_for(item:, params:) }

    it "a new form of a class that matches the current step" do
      expect(form).to be_a(steps.values.first)
    end

    it "is loaded with the params passed in" do
      expect(form.params).to eq(params)
    end
  end

  describe "#current_step" do
    it "by default returns the first step" do
      expect(item_workflow.current_step).to eq(steps.keys.first)
    end

    context "when item has previous step" do
      let(:item) { create :item, last_completed_step: steps.keys.first }

      it "returns the step after the last completed step" do
        expect(item_workflow.current_step).to eq(steps.keys[1])
      end
    end
  end

  describe "#form" do
    it "a new form of a class that matches the current step" do
      expect(item_workflow.form).to be_a(steps.values.first)
    end

    it "is loaded with the params passed in" do
      expect(item_workflow.form.params).to eq(params)
    end
  end
end
