require 'twitter'
load 'lib/blog_post_creator.rb'
load 'lib/blog_post_updater.rb'
load 'lib/blog_post_finder.rb'
load 'lib/blog_tweeter.rb'
class BlogPostsController < ApplicationController
  before_filter :require_author, :except => [:index, :show]

  # GET /blog_posts
  # GET /blog_posts.json
  def index
    @blog_posts = BlogPost.published.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blog_posts }
    end
  end
  # GET /blog_posts/1
  # GET /blog_posts/1.json
  def show
    blog_post_finder = BlogPostFinder.new(self)
    blog_post_finder.find(:with => params, :author? => logged_in?)
  end

  def blog_post_found(blog_post)
    @blog_post = blog_post
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog_post }
    end
  end

  def blog_post_not_found
    flash[:notice] = "Blog post not found"
    redirect_to root_path
  end

  def blog_post_restricted
    # From reader perspective, restricted is the same as missing
    blog_post_not_found
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
    blog_post_creator = BlogPostCreator.new(BlogTweeter.new(self))
    blog_post_creator.create_with(params[:blog_post])
  end

  # The creator will call these VV, depending on what happened with blog post creation
  def blog_post_creation_succeeded(blog_post)
    @blog_post = blog_post
    respond_to do |format|
      format.html { redirect_to edit_blog_post_path(@blog_post), notice: 'The blog post was successfully created.' }
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
      format.html { redirect_to @blog_post, notice: 'The blog post was successfully updated.' }
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
      format.html do
        flash[:success] = "Blog post successfully removed."
        redirect_to blog_posts_url, :success => "Blog post successfully removed."
      end
      format.json { head :no_content }
    end
  end
end
