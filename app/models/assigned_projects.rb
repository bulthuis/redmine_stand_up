class AssignedProjects
	attr_accessor :project, :version, :issues

	def initialize(project, version)
		@project = project
		@version = version
		@issues = version.fixed_issues.count
	end
end
