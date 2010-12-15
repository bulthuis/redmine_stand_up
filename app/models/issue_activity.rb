class IssueActivity
	attr_accessor :issue

	def initialize(issue)
		@issue = issue
	end

	def hours
		@issue.time_entries.inject(0) { |total, time_entry| total + time_entry.hours }
	end
end
