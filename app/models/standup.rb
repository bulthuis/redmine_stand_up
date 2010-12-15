class Standup
	attr_accessor :user, :date

	def initialize(user, date)
		@user = user
		@date = date
	end

	def yesterdays_activity
		YesterdaysActivity.new(@user, @date)
	end

end
