load 'lib/blog_post_creator.rb'
load 'lib/blog_post_updater.rb'
class BlogPostsController < ApplicationController
  # GET /blog_posts
  # GET /blog_posts.json
  def index
    @blog_posts = BlogPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blog_posts }
    end
  end

  # GET /blog_posts/1
  # GET /blog_posts/1.json
  def show
    @blog_post = BlogPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog_post }
    end
  end

  # GET /blog_posts/new
  # GET /blog_posts/new.json
  def new
    @blog_post = BlogPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog_post }
    end
  end

  # GET /blog_posts/1/edit
  def edit
    @blog_post = BlogPost.find(params[:id])
  end

  # POST /blog_posts
  # POST /blog_posts.json
  def create
    blog_post_creator = BlogPostCreator.new(self)
    blog_post_creator.create_with(params[:blog_post])
  end

  # The creator will call these VV, depending on what happened with blog post creation
  def blog_post_creation_succeeded(blog_post)
    @blog_post = blog_post
    respond_to do |format|
      format.html { redirect_to @blog_post, notice: 'Blog post was successfully created.' }
      format.json { render json: @blog_post, status: :created, location: @blog_post }
    end
  end

  def blog_post_creation_failed(blog_post)
    @blog_post = blog_post
    respond_to do |format|
      format.html { render action: "new" }
      format.json { render json: @blog_post.errors, status: :unprocessable_entity }
    end
  end

  # PUT /blog_posts/1
  # PUT /blog_posts/1.json
  def update
    blog_post_updater = BlogPostUpdater.new(self)
    blog_post_updater.update(params)
  end

  def blog_post_update_succeeded(blog_post)
    @blog_post = blog_post
    respond_to do |format|
      format.html { redirect_to @blog_post, notice: 'Blog post was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def blog_post_update_failed(blog_post)
    @blog_post = blog_post
    respond_to do |format|
      format.html { render action: "edit" }
      format.json { render json: @blog_post.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /blog_posts/1
  # DELETE /blog_posts/1.json
  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_url }
      format.json { head :no_content }
    end
  end
end
