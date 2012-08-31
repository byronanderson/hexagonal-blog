require 'logger'
require 'repeater'

class BlogTweeter < Repeater
  def blog_post_creation_succeeded(blog_post)
    Twitter.update tweet_text(blog_post)
  rescue Exception => e
    log_error e
  ensure
    @listener.blog_post_creation_succeeded(blog_post)
  end

  private

  def tweet_text(blog_post)
    "New Blog Post: #{blog_post.title} #{blog_post.url}"
  end

  def log_error(e)
    message = e.message.dup
    message << e.backtrace.to_s
    logger.error message
  end

  def logger
    @logger ||= Logger.new("log/blog_tweeter_error_log.log")
  end
end
