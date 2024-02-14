class ContactPointForm < BaseForm
  validates :contact_name, :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def update_item
    item.metadata["contactPoint"] = contact_point
  end

  def contact_point
    {
      "contactName" => contact_name,
      "email" => email,
    }
  end

  def contact_name
    @contact_name ||= from_params(:contact_name)
  end

  def email
    @email ||= from_params(:email)
  end
end
