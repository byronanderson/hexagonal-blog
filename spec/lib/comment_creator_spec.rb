require 'comment_creator'

class BlogPost; end
describe CommentCreator do
  let(:listener) { stub.as_null_object }
  let(:comment_creator) { CommentCreator.new(listener) }
  let(:parameters) { stub.as_null_object }
  let(:comment) { stub.as_null_object }
  let(:comments) { stub(:build => comment) }
  let(:blog_post) { stub(:comments => comments) }

  before { BlogPost.stub(:find).and_return(blog_post) }


  it "creates comments" do
    comments.should_receive(:build).and_return(comment)
    comment_creator.create_with(parameters)
  end

  context "the creation succeeds" do
    before { comment.stub(:save => true) }

    it "tells its listener comment_creation_succeded if it succeeds" do
      listener.should_receive(:comment_creation_succeeded).with(comment)
      comment_creator.create_with(parameters)
    end
  end

  context "the creation fails" do
    before { comment.stub(:save => false) }

    it "tells its listener comment_creation_failed if it fails" do
      listener.should_receive(:comment_creation_failed).with(comment)
      comment_creator.create_with(parameters)
    end
  end
end
