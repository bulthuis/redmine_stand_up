class YesterdaysActivity
	attr_accessor :user, :date, :project_activities

	def initialize(user, date)
		@user = user
		@date = date

		projects = []
		until projects.count > 0 || @date < @user.created_on.to_date
			@date = @date - 1
			projects = Project.all(
				:include => { :versions => { :fixed_issues => :time_entries } },
				:conditions => { :time_entries => { :user_id => @user.id, :spent_on => @date } })
		end

		@project_activities = []
		projects.each do |project|
			project.versions.each do |version|
				@project_activities << ProjectActivity.new(project, version)
			end
		end
	end

	def hours
		@project_activities.inject(0) { |total, project_activity| total + project_activity.hours }
	end
end
