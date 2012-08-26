class BlogPostLibrarian
  def initialize(listener)
    @listener = listener
  end

  def find(parameters, authority)
    # Author has authority, reader does not
    if authority
      @listener.blog_posts_found(BlogPost.all)
    else
      @listener.blog_posts_found(BlogPost.published)
    end
  end
end
