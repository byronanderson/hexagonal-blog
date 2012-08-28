FactoryGirl.define do
  factory :comment do
    name { "Foo Bar" }
    email { "foo@bar.com" }
    body { "you got it right, dawg" }
    blog_post
  end
end
