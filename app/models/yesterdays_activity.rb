class YesterdaysActivity
	attr_accessor :user, :date, :project_activities

	def initialize(user, date)
		@user = user
		@date = date

		projects = []
		unversioned_issues_projects = []
		until projects.count > 0 || unversioned_issues_projects.count > 0 || @date < @user.created_on.to_date
			@date = @date - 1
			projects = Project.all(
				:include => { :versions => { :fixed_issues => :time_entries } },
				:conditions => { :time_entries => { :user_id => @user.id, :spent_on => @date } })
			unversioned_issues_projects = Project.all(
				:include => { :issues => :time_entries },
				:conditions => {
					:time_entries => { :user_id => @user.id, :spent_on => @date },
					:issues => { :fixed_version_id => nil } })
		end

		@project_activities = []
		projects.each do |project|
			project.versions.each do |version|
				@project_activities << ProjectActivity.new(project, version)
			end
		end

		if unversioned_issues_projects.count > 0
			unversioned_issues_projects.each do |project|
				@project_activities << ProjectActivity.new(project)
			end
		end

		@project_activities = @project_activities.sort_by do |project_activity|
			[ project_activity.project.name,
				project_activity.version.nil? ? '' : project_activity.version.name ]
		end
	end

	def hours
		@project_activities.inject(0) { |total, project_activity| total + project_activity.hours }
	end
end
