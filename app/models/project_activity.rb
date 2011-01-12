class ProjectActivity
	attr_accessor :project, :version, :issue_activities
	
	def initialize(project, version = nil)
		@project = project
		@version = version

		@issue_activities = []
		if version.nil?
			project.issues.each do |issue|
				@issue_activities << IssueActivity.new(issue)
			end
		else
			version.fixed_issues.each do |issue|
				@issue_activities << IssueActivity.new(issue)
			end
		end
	end

	def hours
		@issue_activities.inject(0) { |total, issue_activity| total + issue_activity.hours }
	end
end
