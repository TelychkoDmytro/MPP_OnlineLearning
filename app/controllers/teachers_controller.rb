# frozen_string_literal: true

class TeachersController < ApplicationController
	def subjects_with_opt_outs
		@subjects = current_teacher.subjects
	end

  private

 def student_params
   params.require(:student).permit(:email, :first_name, :last_name, :bio, :group_id, :avatar, :city, :country)
 end
end
