class Player

	def initialize(name)
		@name = name
		@picked = false
	end

	attr_reader :name
	attr_writer :picks, :picked

	def pick
		@picks
	end

	def has_picked?
		@picked
	end

end