Then(/^I am on waiting_room$/) do
  expect(page).to have_content("WAITING")
end

Given(/^a player is already waiting$/) do
	Capybara.session_name = 'session_one'
	visit '/'
	click_on 'New Game'
	fill_in 'name', with: 'Albert'
	click_on 'Submit'
	expect(page).to have_content("WAITING")
end

When(/^I register as a second player$/) do
 	Capybara.session_name = 'session_two'
	visit '/'
	click_on 'New Game'
	fill_in 'name', with: 'YATAAA'
	click_on 'Submit'
	expect(page).to have_content("WAITING")
end

Then(/^I should be shown the game screen$/) do
  expect(page).to have_content("Welcome <%= @player%>")
end