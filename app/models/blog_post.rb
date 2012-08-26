class BlogPost < ActiveRecord::Base
  attr_accessible :body, :title, :published

  scope :published, where("published_at not null")

  def published
    published_at.present?
  end
  alias_method :published?, :published

  def published=(other)
    if other == true
      self.published_at = Time.zone.now
    else
      self.published_at = nil
    end
  end

  def url
    Rails.application.routes.url_helpers.blog_post_url(self)
  end

  def restricted?
    not published?
  end
end
