class AuthorSession
  include ActiveAttr::Model

  attribute :password, :type => String

  validate :has_correct_password?
  def has_correct_password?
    errors.add(:password, "invalid") unless password == AUTHOR_PASSWORD
  end
end
