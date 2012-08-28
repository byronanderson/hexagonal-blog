require 'capybara/rspec'
require 'spec_helper'

feature "reader comments" do
  scenario "reader leaves a comment" do
    # Given there is a published blog post
    blog_post = FactoryGirl.create :blog_post, :published => true

    # When a reader visits it
    visit blog_post_path(blog_post)

    # And fills in his name, email, and a comment
    fill_in "Name", :with => "joe bob"
    fill_in "Email", :with => "joe@bob.com"
    fill_in "Comment", :with => "yer damn tootin'"

    # And submits the comment
    click_on "Submit"

    # Then the comment shows up on the page
    page.should have_content "yer damn tootin'"
  end

  context "author" do
    background do
      Settings.all.should be_empty
      # Given I am a logged in author
      login

      # And comments are enabled
      FactoryGirl.create :settings, :enable_comments => true
    end

    # Disabling this scenario for now- needs database cleaning strategy rethinking
    #scenario "removing a comment", :js => true do
      ## Given a blog post comment
      #blog_post = FactoryGirl.create :blog_post, :published => true
      #comment = FactoryGirl.create :comment, blog_post: blog_post

      ## When I choose to remove it
      #visit blog_post_path(blog_post)
      #click_on "Remove"

      ## Then it does not show up on the page
      #page.should_not have_content comment.body
    #end

    scenario "disabling comments" do
      blog_post = FactoryGirl.create :blog_post, :published => true
      comment = FactoryGirl.create :comment, blog_post: blog_post

      # When I visit my settings page
      visit edit_settings_path

      # And disable comments
      uncheck "Enable comments"
      click_on "Save Settings"

      # Then no comment forms show up
      visit blog_post_path(blog_post)
      page.should_not have_field "Comment"

      # And existing comments do not show up
      visit blog_post_path(comment.blog_post)
      page.should_not have_content(comment.body)
    end
  end
end
