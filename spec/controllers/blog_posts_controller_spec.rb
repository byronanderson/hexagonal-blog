require 'spec_helper'


describe BlogPostsController do
  before do
    Twitter.stub(:update)
  end

  def valid_attributes
    {}
  end

  def valid_session
    {}
  end

  describe "GET index" do
    context "when requested by the author" do
      before { controller.stub(:logged_in? => true) }

      it "assigns all blog posts as @blog_posts" do
        unpublished_blog_post = FactoryGirl.create :blog_post, :published => false
        get :index, {}, valid_session
        assigns(:blog_posts).should eq([unpublished_blog_post])
      end
    end

    context "when requested by a reader" do
      it "assigns all published blog posts as @blog_posts" do
        published_blog_post = FactoryGirl.create :blog_post, :published => true
        unpublished_blog_post = FactoryGirl.create :blog_post, :published => false
        get :index, {}, valid_session
        assigns(:blog_posts).should eq([published_blog_post])
      end
    end
  end

  describe "GET show" do
    context "with a published blog post" do
      let!(:blog_post) { FactoryGirl.create(:blog_post, :published => true) }

      it "assigns the requested blog_post as @blog_post" do
        get :show, {:id => blog_post.to_param}, valid_session
        assigns(:blog_post).should eq(blog_post)
      end
    end

    context "with an unpublished blog post" do
      let!(:blog_post) { FactoryGirl.create(:blog_post, :published => false) }

      context "as a logged in author" do
        before { controller.stub(:logged_in? => true) }

        it "assigns the requested blog_post as @blog_post" do
          get :show, {:id => blog_post.to_param}, valid_session
          assigns(:blog_post).should eq(blog_post)
        end
      end

      context "as a reader" do
        it "redirects to the root_path" do
          get :show, {:id => blog_post.to_param}, valid_session
          response.should redirect_to root_path
        end
      end
    end
  end

  context "as the author" do

    before { controller.stub(:require_author) }

    describe "GET new" do
      it "assigns a new blog_post as @blog_post" do
        get :new, {}, valid_session
        assigns(:blog_post).should be_a_new(BlogPost)
      end
    end

    describe "GET edit" do
      it "assigns the requested blog_post as @blog_post" do
        blog_post = BlogPost.create! valid_attributes
        get :edit, {:id => blog_post.to_param}, valid_session
        assigns(:blog_post).should eq(blog_post)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new BlogPost" do
          expect {
            post :create, {:blog_post => valid_attributes}, valid_session
          }.to change(BlogPost, :count).by(1)
        end

        it "assigns a newly created blog_post as @blog_post" do
          post :create, {:blog_post => valid_attributes}, valid_session
          assigns(:blog_post).should be_a(BlogPost)
          assigns(:blog_post).should be_persisted
        end

        it "redirects to the created blog_post's edit page" do
          post :create, {:blog_post => valid_attributes}, valid_session
          response.should redirect_to(edit_blog_post_path(BlogPost.last))
        end

        it "tweets the blog post's title" do
          Twitter.should_receive(:update)
          post :create, {:blog_post => valid_attributes}, valid_session
        end

        it "logs the creation of a new blog post" do
          BlogPostCreationActivity.should_receive(:create)
          post :create, {:blog_post => valid_attributes}, valid_session
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved blog_post as @blog_post" do
          # Trigger the behavior that occurs when invalid params are submitted
          BlogPost.any_instance.stub(:save).and_return(false)
          post :create, {:blog_post => {}}, valid_session
          assigns(:blog_post).should be_a_new(BlogPost)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          BlogPost.any_instance.stub(:save).and_return(false)
          post :create, {:blog_post => {}}, valid_session
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested blog_post" do
          blog_post = BlogPost.create! valid_attributes
          # Assuming there are no other blog_posts in the database, this
          # specifies that the BlogPost created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          BlogPost.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => blog_post.to_param, :blog_post => {'these' => 'params'}}, valid_session
        end

        it "assigns the requested blog_post as @blog_post" do
          blog_post = BlogPost.create! valid_attributes
          put :update, {:id => blog_post.to_param, :blog_post => valid_attributes}, valid_session
          assigns(:blog_post).should eq(blog_post)
        end

        it "redirects to the blog_post" do
          blog_post = BlogPost.create! valid_attributes
          put :update, {:id => blog_post.to_param, :blog_post => valid_attributes}, valid_session
          response.should redirect_to(blog_post)
        end
      end

      describe "with invalid params" do
        it "assigns the blog_post as @blog_post" do
          blog_post = BlogPost.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          BlogPost.any_instance.stub(:save).and_return(false)
          put :update, {:id => blog_post.to_param, :blog_post => {}}, valid_session
          assigns(:blog_post).should eq(blog_post)
        end

        it "re-renders the 'edit' template" do
          blog_post = BlogPost.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          BlogPost.any_instance.stub(:save).and_return(false)
          put :update, {:id => blog_post.to_param, :blog_post => {}}, valid_session
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested blog_post" do
        blog_post = BlogPost.create! valid_attributes
        expect {
          delete :destroy, {:id => blog_post.to_param}, valid_session
        }.to change(BlogPost, :count).by(-1)
      end

      it "redirects to the blog_posts list" do
        blog_post = BlogPost.create! valid_attributes
        delete :destroy, {:id => blog_post.to_param}, valid_session
        response.should redirect_to(blog_posts_url)
      end
    end
  end

end
