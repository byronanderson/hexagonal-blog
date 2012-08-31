require 'resource_creator'

class CommentCreator < ResourceCreator
  def create_with(blog_post_id, parameters)
    @scope = BlogPost.find(blog_post_id).comments
    super(parameters)
  end

  def scope
    @scope
  end

  def resource_name
    "comment"
  end
end
