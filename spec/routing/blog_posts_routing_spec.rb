require "spec_helper"

describe BlogPostsController do
  describe "routing" do

    it "routes to #index" do
      get("/blog_posts").should route_to("blog_posts#index")
    end

    it "routes to #new" do
      get("/blog_posts/new").should route_to("blog_posts#new")
    end

    it "routes to #show" do
      get("/blog_posts/1").should route_to("blog_posts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/blog_posts/1/edit").should route_to("blog_posts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/blog_posts").should route_to("blog_posts#create")
    end

    it "routes to #update" do
      put("/blog_posts/1").should route_to("blog_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/blog_posts/1").should route_to("blog_posts#destroy", :id => "1")
    end

  end
end

describe AuthorSessionsController do
  it "routes to #new" do
    get("/author_session/new").should route_to("author_sessions#new")
  end

  it "routes to #create" do
    post("/author_session").should route_to("author_sessions#create")
  end

  it "routes to #destroy" do
    delete("/author_session").should route_to("author_sessions#destroy")
  end
end
