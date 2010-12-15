class StandupController < ApplicationController
	unloadable
	
	def index
		@groups = User.current.groups
		
		if @groups.count > 0
			@group = @groups.first

			if params[:group]
				param_group = Group.find(params[:group])

				if @groups.include? param_group
					@group = param_group
				else
					render_403
				end
			end
		end
	end
end
