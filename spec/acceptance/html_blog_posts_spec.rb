require 'capybara/rspec'
require 'spec_helper'

feature 'blog post content' do
  scenario 'blog posts can have html' do
    # Given I am logged in author
    login

    # When I put a html into my blog post
    visit new_blog_post_path
    fill_in "Title", :with => "Foobar"
    fill_in "Body", :with => "<div id='whatever'></div>"
    click_on "Create Blog post"

    # Then the html should show up in the blog post's page
    page.should have_selector "div#whatever"
  end
end
