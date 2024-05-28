# frozen_string_literal: true

require "test_helper"

class StudentAttendancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_attendances_index_url
    assert_response :success
  end

  test "should get new" do
    get student_attendances_new_url
    assert_response :success
  end

  test "should get show" do
    get student_attendances_show_url
    assert_response :success
  end

  test "should get edit" do
    get student_attendances_edit_url
    assert_response :success
  end
end
