class BlogPostCreator
  def initialize(listener)
    @listener = listener
  end

  def create_with(params)
    blog_post = BlogPost.new(params)
    if blog_post.save
      @listener.blog_post_creation_succeeded(blog_post)
    else
      @listener.blog_post_creation_failed(blog_post)
    end
  end
end
