require "rails_helper"

RSpec.describe Organisation, type: :model do
  let(:data) do
    YAML.load_file(
      Rails.root.join("data/uk-gov-orgs.yaml"),
      permitted_classes: [Date],
    )
  end
  let(:org_data) { data.dig "enums", "OrganisationValues", "permissible_values" }

  describe ".all" do
    subject(:all) { described_class.all }

    it "includes all the organisations listed in the data" do
      expect(all.length).to eq(org_data.length)
    end

    it "uses the data's key as id" do
      expect(all.first.id).to eq(org_data.keys.first)
    end

    it "uses the data's description as name" do
      expect(all.first.name).to eq(org_data.values.first["description"])
    end
  end
end
