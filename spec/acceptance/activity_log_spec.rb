require 'capybara/rspec'
require 'spec_helper'

feature "activity logging" do
  scenario "logging of blog creation" do
    # Given I am the author and I am logged in
    login

    # When I create a blog post
    create_blog_post

    # And I visit the activity log page
    visit activities_path

    # Then I should see the blog post logged
    page.should have_content "Foobar"
  end

  def create_blog_post
    visit new_blog_post_path
    fill_in "Title", :with => "Foobar"
    fill_in "Body", :with => "baz"
    click_on "Create Blog post"
    return BlogPost.last
  end

  scenario "logging of comment creation" do
    # Given there is a blog post
    blog_post = FactoryGirl.create(:blog_post, :published => true)

    # When a comment is left on it
    comment = comment_on(blog_post)

    # Then the comment creation is logged
    login
    visit activities_path
    page.should have_content comment.name
  end

  def comment_on(blog_post)
    visit blog_post_path(blog_post)
    fill_in "Name", :with => "Foo Bar"
    fill_in "Comment", :with => "Body"
    click_on "Submit"
    return Comment.last
  end
end
