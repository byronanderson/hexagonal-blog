require 'echo'

class ActivityLogger < Echo
  def blog_post_creation_succeeded(blog_post)
    BlogPostCreationActivity.create({ :content => blog_post.title })
    @listener.blog_post_creation_succeeded(blog_post)
  end

  def comment_creation_succeeded(comment)
    CommentCreationActivity.create({ :content => "#{comment.name} left a comment" })
    @listener.comment_creation_succeeded(comment)
  end
end
