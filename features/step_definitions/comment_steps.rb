Given /^I have comments with body (.+)$/ do |group|
  group.split(', ').each do |body|
    Comment.create!(:body => body)
  end
end

Then /^I should see a comment created message$/ do
  page.should have_content "Comment was successfully created."
end
