Feature: Sessions
	In order to play Rock Paper Scissors
	with two players
	and 2 different sessions

Scenario: A player can register
	Given I am on the homepage
	When I click "New Game"
	And I enter my name
	When I press "Submit"
	Then I am on the waiting_room

Scenario: We are waiting the 2 player
	Given a player is already waiting
	When I register as a second player
	Then I should be shown the game screen