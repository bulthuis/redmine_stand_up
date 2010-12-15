class ProjectActivity
	attr_accessor :project, :version, :issue_activities

	def initialize(project, version)
		@project = project
		@version = version

		@issue_activities = []
		version.fixed_issues.each do |issue|
			if issue.time_entries.count > 0
				@issue_activities << IssueActivity.new(issue)
			end
		end
	end

	def hours
		@issue_activities.inject(0) { |total, issue_activity| total + issue_activity.hours }
	end
end
