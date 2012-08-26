load 'lib/blog_post_librarian.rb'

class BlogPost; end
describe BlogPostLibrarian do
  let(:listener) { stub.as_null_object }
  let(:librarian) { BlogPostLibrarian.new(listener) }
  let(:blog_posts) { stub }
  let(:params) { {} }

  context "with an author" do
    let(:author) { true }

    it "shows all the blog posts" do
      BlogPost.stub(:all).and_return(blog_posts)
      listener.should_receive(:blog_posts_found).with(blog_posts)
      librarian.find(params, author)
    end
  end

  context "with a reader" do
    let(:author) { false }

    it "shows all the blog posts" do
      BlogPost.stub(:published).and_return(blog_posts)
      listener.should_receive(:blog_posts_found).with(blog_posts)
      librarian.find(params, author)
    end
  end
end
