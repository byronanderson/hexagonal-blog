load 'lib/blog_tweeter.rb'

module Twitter; end

describe BlogTweeter do
  let(:listener) { stub.as_null_object }
  let(:blog_tweeter) { BlogTweeter.new(listener) }
  let(:blog_post) { stub(:title => "Title", :id => 30, :url => "/blog_posts/30") }

  context "blog creation succeeded" do
    before do
      Twitter.stub(:update)
    end

    describe "exception handling" do
      let(:logger) { stub.as_null_object }

      before do
        Twitter.stub(:update).and_raise(Exception)
        Logger.stub(:new).and_return(logger)
      end

      it "should swallow exceptions that the Twitter gem raises" do
        expect {
          blog_tweeter.blog_post_creation_succeeded(blog_post)
        }.not_to raise_error
      end

      it "should log the error" do
        logger.should_receive(:error)
        blog_tweeter.blog_post_creation_succeeded(blog_post)
      end
    end

    describe "status message" do
      before do
        Twitter.stub(:update) { |status| @status = status }
        blog_tweeter.blog_post_creation_succeeded(blog_post)
      end

      subject { @status }

      it { should include blog_post.title }
      it { should include "/blog_posts/#{blog_post.id}" }
    end

    it "passes the message to its listener" do
      listener.should_receive(:blog_post_creation_succeeded).with(blog_post)
      blog_tweeter.blog_post_creation_succeeded(blog_post)
    end
  end

  context "blog creation failed" do
    it "does not tweet anything" do
      Twitter.should_not_receive(:update)
      blog_tweeter.blog_post_creation_failed(blog_post)
    end

    it "passes the message to its listener" do
      listener.should_receive(:blog_post_creation_failed).with(blog_post)
      blog_tweeter.blog_post_creation_failed(blog_post)
    end
  end
end
