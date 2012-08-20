load 'lib/blog_post_updater.rb'
class BlogPost; end
describe BlogPostUpdater do
  let(:blog_post) { stub.as_null_object }
  let(:attributes) { stub }
  let(:params) { { :blog_post => attributes } }
  let(:listener) { stub.as_null_object }
  let(:blog_post_updater) { BlogPostUpdater.new(listener) }

  before do
    BlogPost.stub(:find).and_return(blog_post)
  end

  it "should update a blog post" do
    blog_post.should_receive(:update_attributes).with(attributes)
    blog_post_updater.update(params)
  end

  context "upon update success" do
    before { blog_post.stub(:update_attributes => true) }
    it "should send the listener the message that the blog post has been updated" do
      listener.should_receive(:blog_post_update_succeeded).with(blog_post)
      blog_post_updater.update(params)
    end
  end

  context "upon update failure" do
    before { blog_post.stub(:update_attributes => false) }
    it "should send the listener the message that the blog post has not been updated" do
      listener.should_receive(:blog_post_update_failed).with(blog_post)
      blog_post_updater.update(params)
    end
  end
end
