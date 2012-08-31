load 'lib/activity_logger.rb'

class Activity; end
class BlogPostCreationActivity < Activity; end
class CommentCreationActivity < Activity; end

describe ActivityLogger do
  describe "#blog_post_creation_succeeded(blog_post)" do
    let(:blog_post) { stub(:title => "foobar") }
    let(:listener) { stub.as_null_object }
    subject(:activity_logger) { ActivityLogger.new(listener) }

    it "should log the blog post's title" do
      content = nil
      BlogPostCreationActivity.should_receive(:create) { |hash| content = hash[:content] }
      activity_logger.blog_post_creation_succeeded(blog_post)
      content.should =~ /#{blog_post.title}/
    end
  end

  describe "#comment_creation_succeeded(comment)" do
    let(:blog_post) { stub(:title => "foobar") }
    let(:comment) { stub(:blog_post => blog_post, :name => "Byron Anderson") }
    let(:listener) { stub.as_null_object }
    subject(:activity_logger) { ActivityLogger.new(listener) }

    it "should log the commenter's name" do
      content = nil
      CommentCreationActivity.should_receive(:create) { |hash| content = hash[:content] }
      activity_logger.comment_creation_succeeded(comment)
      content.should =~ /#{comment.name} left a comment/
    end
  end
end
