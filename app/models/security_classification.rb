module SecurityClassification
  VALUES = %w[OFFICIAL SECRET TOP_SECRET NOT_APPLICABLE].freeze

  def self.values
    VALUES
  end
end
