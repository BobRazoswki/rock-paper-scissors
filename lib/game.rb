class Game 

	def initialize
		@players = []
	end

	BEATS = {rock: :scissors, scissors: :paper, paper: :rock}

	attr_reader :players, :player1, :player2

	def add_(player)
		@players << player
	end

	def enough_players?
		@players.count == 2
	end

	def both_played?
		@picks == 2
	end

	def player1
		@players.first
	end

	def player2
		@players.last
	end

	def both_picked?
		@players.all? { |player|  player.has_picked? }
	end

	def waiting_for? player
		!player.has_picked?
	end

	def winner
			return "Draw" if player1.pick == player2.pick
			return player1 if BEATS[normalize(player1.pick)] == normalize(player2.pick)
			player2 
	end

	def looser
		return player2 if BEATS[normalize(player1.pick)] == normalize(player2.pick)
			player1 
	end

	def normalize(pick)
		pick.downcase.to_sym
	end
end