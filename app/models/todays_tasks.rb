class TodaysTasks
	attr_accessor :due, :assigned_projects

	def initialize(user, date)
		@due = Issue.all(
			:conditions => ['assigned_to_id = ? and due_date <= ?', user.id, date]).count

		projects = Project.all(
			:include => { :versions => { :fixed_issues => :status } },
			:conditions => { :issues => { :assigned_to_id => user }, :issue_statuses => { :is_closed => false } } )

		@assigned_projects = []
		projects.each do |project|
			project.versions.each do |version|
				@assigned_projects << AssignedProjects.new(project, version)
			end
		end
	end
end
