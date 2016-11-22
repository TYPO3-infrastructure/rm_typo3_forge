When(/^I (un|)?check "([^"]*)"$/) do |should_uncheck, box_id|
  if should_uncheck
    uncheck(box_id)
  else
    check(box_id)
  end
end
