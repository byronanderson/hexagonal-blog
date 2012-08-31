require 'comment_creator'
class CommentsController < ApplicationController

  def create
    comment_creator = CommentCreator.new(ActivityLogger.new(self))
    comment_creator.create_with(params[:blog_post_id], params[:comment])
  end

  def comment_creation_succeeded(comment)
    redirect_to comment.blog_post
  end

  def comment_creation_failed(comment)
    # not sure what happens here, no failure has pointed for me what to do
  end

  def destroy
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = @blog_post.comments.find(params[:id])
    @comment.remove!

    redirect_to @blog_post
  end
end
