Given /^I have stories with title, url as "(.+)"$/ do |stories|
     parts = stories.split(', ')
       Story.create!(:title => parts[0], :url => parts[1])
end

Then /^I should see a story created message$/ do
  page.should have_content "Story was successfully created."
end

Then(/^I should see a story not created message$/) do
  page.should have_content "Story was not created"
end

Then /^I should see the message "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

