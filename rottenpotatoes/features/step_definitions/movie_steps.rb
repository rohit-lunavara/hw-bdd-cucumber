# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    Movie.create(:title => movie['title'], :rating => movie['rating'], :release_date => movie['release_date'])
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  page.body is the entire content of the page as a string.
  content = page.body
  expect(content.index(e1)).to be < content.index(e2)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(' ')
  ratings.each do
    |rating|
    if uncheck
      uncheck('ratings_' + rating)
    else
      check('ratings_' + rating)
    end
  end
end

Given(/^I click "(.*)"$/) do |button|
  click_button(button)
end

Then(/^I should (not )?see movies with the following ratings: (.*)$/) do |dont_show, rating_list|
  ratings = rating_list.split(' ')
  all('#movies tr > td:nth-child(2)').each do |td|
    if dont_show
      ratings.should_not include td.text
    else
      ratings.should include td.text
    end
  end
end

Then /I should see all the movies/ do
  # -1 because of the header
  rows = all('#movies tr').size - 1
  expect(rows).to eq 10
end
