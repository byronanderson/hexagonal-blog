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
end
