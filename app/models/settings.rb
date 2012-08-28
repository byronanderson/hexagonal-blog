class Settings < ActiveRecord::Base
  attr_accessible :enable_comments

  def self.fetch
    first || create!
  end

  def self.comments_enabled?
    fetch.enable_comments?
  end
end
