Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    user[:profile] = Profile.find_by_label user[:profile]
    User.create! user
  end
end

Given /the following articles exist/ do |articles|
  articles.hashes.each do |article|
    article[:user] = User.find_by_login article[:author]
    Article.create! article
  end
end

Then /^I should see "(.*?)" field$/ do |field_name|
  page.should have_field(field_name)
end

Then /^I should see "(.*?)" button$/ do |name|
  page.should have_button(name)
end

