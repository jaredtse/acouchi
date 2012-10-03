When /^I write the text "(.*?)"$/ do |text|
  page.enter_text(0, text)
end

When /^I clear the text$/ do
  page.clear_edit_text(0)
end

Then /^I see "(.*?)"$/ do |text|
  page.should have_text text
end

Then /^I do not see "(.*?)"$/ do |text|
  page.should_not have_text text
end
