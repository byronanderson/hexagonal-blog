class BlogPostUpdater
  def initialize(listener)
    @listener = listener
  end

  def update(params)
    blog_post = BlogPost.find(params[:id])
    if blog_post.update_attributes(params[:blog_post])
      @listener.blog_post_update_succeeded(blog_post)
    else
      @listener.blog_post_update_failed(blog_post)
    end
  end
end
