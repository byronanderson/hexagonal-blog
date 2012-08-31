require 'resource_creator'

class BlogPostCreator < ResourceCreator
  def scope
    BlogPost
  end

  def resource_name
    "blog_post"
  end
end
