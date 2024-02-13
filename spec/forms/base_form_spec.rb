require "rails_helper"

RSpec.describe BaseForm, type: :form do
  let(:item) { create :item }
  let(:params) { {} }
  let(:base_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "raises error telling coder to put logic in update_item method in child class" do
      expect { base_form.save }.to raise_error("this method should be overwritten in child object")
    end
  end
end
