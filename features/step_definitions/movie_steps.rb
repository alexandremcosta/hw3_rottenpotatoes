# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie[:title], :rating => movie[:rating], :release_date => movie[:release_date])
  end
  #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I check the following ratings: (.*)/ do |rating_list|
  rating_list = rating_list.split(', ')
  rating_list.each do |r|
    r = 'ratings_' + r
    check(r)
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

When /I don't check any ratings/ do
  rating_list = Movie.all_ratings
  rating_list.each do |r|
    r = 'ratings_' + r
    uncheck(r)
  end
end

When /I press (.*)/ do |button|
  click_button(button)
end

Then /I should (not )?see (.*)/ do |no_content, text|
  if text =~ /all of the movies/
    Movie.all.each do |m|
      m = m.title
      assert page.has_content?(m)
    end
  elsif text =~ /nothing at all/
    Movie.all.each do |m|
      m = m.title
      assert page.has_no_content?(m)
    end
  else
    text = text.split(', ')
    text.each do |t|
      if no_content
        assert page.has_no_content?(t)
      else
        assert page.has_content?(t)
      end
    end
  end
end

#Then /I should see (all of the movies|nothing)/ do |content|
#end

