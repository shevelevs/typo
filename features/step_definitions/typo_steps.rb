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

Given /^I merge with "(.*?)"$/ do |article_title|
  a = Article.find_by_title(article_title)
  fill_in 'merge_with', :with => a.id
  click_button 'Merge'
end

Then /^article body should contain "(.*?)"$/ do |value|
  field = find_field('article[body_and_extended]')
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  field_value.should =~ /#{value}/
end
