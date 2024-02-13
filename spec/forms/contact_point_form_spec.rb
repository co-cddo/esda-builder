RSpec.describe ContactPointForm, type: :form do
  let(:item) { create :item }
  let(:contact_name) { Faker::Name.name }
  let(:email) { Faker::Internet.email(domain: "example.com") }
  let(:params) do
    {
      item: {
        contact_name:,
        email:,
      },
    }
  end
  let(:contact_point_form) { described_class.new(item:, params:) }

  describe "#save" do
    it "saves the name and email to a contact point object in metadata" do
      contact_point_form.save
      expected = { "contactName" => contact_name, "email" => email }
      expect(item.reload.metadata["contactPoint"]).to eq(expected)
    end

    context "if contact name missing" do
      let(:contact_name) { "" }

      it "invalidates form" do
        expect(contact_point_form).to be_invalid
      end
    end

    context "if email missing" do
      let(:email) { "" }

      it "invalidates form" do
        expect(contact_point_form).to be_invalid
      end
    end

    context "if email not valid email" do
      let(:email) { "invalid" }

      it "invalidates form" do
        expect(contact_point_form).to be_invalid
      end
    end
  end
end
