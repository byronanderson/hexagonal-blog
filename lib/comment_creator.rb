require 'echo'

class CommentCreator < Echo
  def create_with(parameters)
    blog_post = BlogPost.find(parameters[:blog_post_id])
    comment = blog_post.comments.build(parameters[:comment])
    if comment.save
      @listener.comment_creation_succeeded(comment)
    else
      @listener.comment_creation_failed(comment)
    end
  end
end
