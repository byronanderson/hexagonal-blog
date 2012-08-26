require 'capybara/rspec'
require 'spec_helper'

feature "non-logged in users cannot CUD blog posts" do
end

feature "blog author can do things with blog posts" do
  background %q{
    Given I am the blog's author
    When I log in
  } do
    login
  end

  scenario "make new posts", %q{
    Then I can make new posts
  } do
    visit new_blog_post_path

    # fill in blog post form
    fill_in "Title", :with => "Foobar"
    fill_in "Body", :with => "Lorem Ipsum"
    click_on "Create Blog post"

    # Should be on preview page
    page.should have_content "Foobar"

    check "Publish"
    click_on "Update"

    page.should have_content "The blog post was successfully updated"
  end

  scenario "edit existing posts", %q{
    Then I can edit existing posts
  } do
    blog_post = FactoryGirl.create :blog_post

    #visit the blog post's page
    visit edit_blog_post_path(blog_post)

    fill_in "Title", :with => "Foobar"
    click_on "Update Blog post"

    page.should have_content "The blog post was successfully updated"
    page.should have_content "Foobar"
  end

  scenario "remove existing posts", %q{
    Then I can destroy existing posts
  } do
    blog_post = FactoryGirl.create :blog_post, :published => true

    visit blog_posts_path

    click_on "Destroy"

    # You should be told that the blog post has been removed
    page.should have_content "Blog post successfully removed"
  end
end

feature "readers can read the blog posts" do
  background "there is a published blog post" do
    @blog_post = FactoryGirl.create :blog_post, :published => true
  end

  scenario "users can read blog posts" do
    visit blog_posts_path

    page.should have_content @blog_post.title
  end

  scenario "users cannot edit blog posts" do
    visit edit_blog_post_path(@blog_post)

    page.should have_content "Access denied"
  end

  scenario "readers cannot read unpublished blog_posts" do
    @blog_post.published = false
    @blog_post.save

    visit blog_posts_path

    page.should_not have_content @blog_post.title

    visit blog_post_path(@blog_post)

    page.should_not have_content @blog_post.title
  end
end
