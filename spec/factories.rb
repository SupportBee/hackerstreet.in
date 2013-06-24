FactoryGirl.define do 
  factory :user do |user|
    user.name                  "Michael Hartl"
    user.email                 "mhartl@example.com"
    user.password              "foobar"
    user.password_confirmation "foobar"
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "person-#{n}@example.com"
  end
end

FactoryGirl.define do
  sequence :name do |n|
    "Person #{n}"
  end
end

FactoryGirl.define do
  factory :story do |story|
    story.title "New Story"
    story.url   "www.example.com"
    story.text  "this is a sample test"
  end
end

FactoryGirl.define do
  factory :comment do |comment|
    comment.content "New Comment"
  end
end

FactoryGirl.define do 
  factory :delayed_jobs do |job|
    job.queue "new queue"
  end
end
