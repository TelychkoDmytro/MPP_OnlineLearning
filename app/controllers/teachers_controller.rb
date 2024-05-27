# frozen_string_literal: true

class TeachersController < ApplicationController

	private

	def student_params
		params.require(:student).permit(:email, :first_name, :last_name, :bio, :group_id, :avatar, :city, :country)
	end
end
