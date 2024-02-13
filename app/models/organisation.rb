class Organisation
  SOURCE_FILE = Rails.root.join("data/uk-gov-orgs.yaml")

  def self.data
    YAML.load_file(SOURCE_FILE, permitted_classes: [Date])
  end

  def self.all
    @all ||= data.dig("enums", "OrganisationValues", "permissible_values").map do |id, values|
      new(id:, name: values["description"])
    end
  end

  attr_accessor :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end
end
