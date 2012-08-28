require 'spec_helper'

describe Comment do
  describe "#remove" do
    it "should set removed_at to true" do
      comment = FactoryGirl.build :comment
      comment.remove!
      comment.removed_at.should be_within(1.second).of(Time.now)
    end
  end
end
