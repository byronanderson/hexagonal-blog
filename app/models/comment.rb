class Comment < ActiveRecord::Base
  attr_accessible :body, :email, :name
  default_scope { visible }

  scope :visible, where(removed_at: nil)
  scope :removed, where("removed_at IS NOT NULL")

  belongs_to :blog_post

  def remove!
    self.removed_at = Time.zone.now
    save!
  end
end
