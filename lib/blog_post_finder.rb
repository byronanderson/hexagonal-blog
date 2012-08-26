class BlogPostFinder
  def initialize(listener)
    @listener = listener
  end

  def find(options)
    blog_post = BlogPost.find_by_id(options[:with][:id])

    if blog_post.nil?
      @listener.blog_post_not_found
    elsif blog_post.restricted?
      handle_restriction(blog_post, options)
    else
      @listener.blog_post_found(blog_post)
    end
  end

  private

  def handle_restriction(blog_post, options)
    if options[:author?]
      @listener.blog_post_found(blog_post)
    else
      @listener.blog_post_restricted
    end
  end
end
