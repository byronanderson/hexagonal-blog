require 'spec_helper'
describe BlogPost do
  describe "#published" do
    it "removes published_at if pub" do
      bp = BlogPost.new.tap { |bp| bp.published_at = Time.now }
      bp.published = false
      bp.published_at.should be_nil
    end

    it "sets published_at to the current_time when set to true" do
      BlogPost.new(:published => true).published_at.should be_within(1.second).of(Time.now)
    end
  end

  context "when unpublished" do
    subject(:unpublished_blog_post) { BlogPost.new(:published => false) }
    it { should be_restricted }
  end

  context "when published" do
    subject(:published_blog_post) { BlogPost.new(:published => true) }
    it { should_not be_restricted }
  end

  describe ".published" do
    it "scopes queries to published blog posts" do
      FactoryGirl.create :blog_post, :published => false
      FactoryGirl.create :blog_post, :published => true
      BlogPost.published.count.should == 1
    end
  end
end
