class BlogPost < ActiveRecord::Base
  attr_accessible :body, :title, :published

  def published
    published_at.present?
  end

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
end
