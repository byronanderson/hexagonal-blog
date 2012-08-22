class BlogPost < ActiveRecord::Base
  attr_accessible :body, :title

  def url
    Rails.application.routes.url_helpers.blog_post_url(self)
  end
end
