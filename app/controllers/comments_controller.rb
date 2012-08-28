class CommentsController < ApplicationController

  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = @blog_post.comments.build(params[:comment])

    if @comment.save
      redirect_to @blog_post
    else
      # not sure
    end
  end

  def destroy
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = @blog_post.comments.find(params[:id])
    @comment.remove!

    redirect_to @blog_post
  end
end
