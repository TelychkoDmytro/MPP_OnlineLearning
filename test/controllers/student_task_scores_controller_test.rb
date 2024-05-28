# frozen_string_literal: true

require "test_helper"

class StudentTaskScoresControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get student_task_scores_edit_url
    assert_response :success
  end

  test "should get update" do
    get student_task_scores_update_url
    assert_response :success
  end
end
