class ProfilesController < ApplicationController
	before_action :authenticate_student!
	before_action :set_profile, only: [:show, :edit, :update]

	def show
	end

	def edit
	end

	def update
		if @profile.update(profile_params)
			redirect_to @profile, notice: "Profile was successsfully updated"
		else
			render :edit
		end
	end

	private

	def set_profile
		@profile = current_student.profile
	end

	def profile_params
		params.require(:profile).permit(:bio, :age)
	end
end
