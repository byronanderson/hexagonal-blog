load 'lib/blog_post_finder.rb'

class BlogPost; end
describe BlogPostFinder do
  let(:listener) { stub.as_null_object }
  subject(:blog_post_finder) { BlogPostFinder.new(listener) }
  let(:params) { { :id => 1234 } }

  describe "#find" do
    context "blog post not found" do

      before { BlogPost.stub(:find_by_id) }

      it "sends the message :blog_post_not_found if a blog post is not found" do
        listener.should_receive(:blog_post_not_found)
        blog_post_finder.find(:with => params)
      end
    end

    context "when blog post found" do
      let(:blog_post) { stub }

      before { BlogPost.stub(:find_by_id => blog_post) }

      it "sends the message :blog_post_found if the blog post is not restricted" do
        blog_post.stub(:restricted? => false)
        listener.should_receive(:blog_post_found).with(blog_post)
        blog_post_finder.find(:with => params)
      end

      it "sends the message :blog_post_restricted if the blog post is restricted" do
        blog_post.stub(:restricted? => true)
        listener.should_receive(:blog_post_restricted)
        blog_post_finder.find(:with => params)
      end

      context "author logged in" do
        it "sends the message :blog_post_found if the blog post is restricted" do
          blog_post.stub(:restricted? => true)
          listener.should_receive(:blog_post_found).with(blog_post)
          blog_post_finder.find(:with => params, :author? => true)
        end
      end
    end
  end
end
