load 'lib/blog_post_creator.rb'

class BlogPost; end
describe BlogPostCreator do
  let(:listener) { stub.as_null_object }
  let(:blog_post_creator) { BlogPostCreator.new(listener) }
  let(:params) { stub }
  it "should create the blog post" do
    BlogPost.should_receive(:new).with(params).and_return(stub.as_null_object)
    blog_post_creator.create_with(params)
  end

  context "when blog post creation is successful" do
    let(:blog_post) { stub(:save => true) }
    before { BlogPost.stub(:new).and_return(blog_post) }
    it "should send to the listener the message :blog_post_creation_succeeded with the blog_post object" do
      listener.should_receive(:blog_post_creation_succeeded).with(blog_post)
      blog_post_creator.create_with(params)
    end
  end

  context "when blog post creation is unsuccessful" do
    let(:blog_post) { stub(:save => false) }
    before { BlogPost.stub(:new).and_return(blog_post) }
    it "should send to the listener the message :blog_post_creation_succeeded with the blog_post object" do
      listener.should_receive(:blog_post_creation_failed).with(blog_post)
      blog_post_creator.create_with(params)
    end
  end
end
