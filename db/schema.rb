# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_05_25_140726) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "group_schedules", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "schedule_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_schedules_on_group_id"
    t.index ["schedule_id"], name: "index_group_schedules_on_schedule_id"
  end

  create_table "group_subjects", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_subjects_on_group_id"
    t.index ["subject_id"], name: "index_group_subjects_on_subject_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.integer "head_student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["head_student_id"], name: "index_groups_on_head_student_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "bio"
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_profiles_on_student_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "time"
    t.integer "teacher_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "schedule_type"
    t.index ["subject_id"], name: "index_schedules_on_subject_id"
    t.index ["teacher_id"], name: "index_schedules_on_teacher_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
    t.string "city"
    t.string "country"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["group_id"], name: "index_students_on_group_id"
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "subject_teachers", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_subject_teachers_on_subject_id"
    t.index ["teacher_id"], name: "index_subject_teachers_on_teacher_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "head_teacher_id"
    t.index ["head_teacher_id"], name: "index_subjects_on_head_teacher_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "subject_id", null: false
    t.string "max_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "earned_score"
    t.string "title"
    t.string "description"
    t.index ["student_id"], name: "index_tasks_on_student_id"
    t.index ["subject_id"], name: "index_tasks_on_subject_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "country"
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "group_schedules", "groups"
  add_foreign_key "group_schedules", "schedules"
  add_foreign_key "group_subjects", "groups"
  add_foreign_key "group_subjects", "subjects"
  add_foreign_key "groups", "students", column: "head_student_id"
  add_foreign_key "profiles", "students"
  add_foreign_key "schedules", "subjects"
  add_foreign_key "schedules", "teachers"
  add_foreign_key "subject_teachers", "subjects"
  add_foreign_key "subject_teachers", "teachers"
  add_foreign_key "subjects", "teachers", column: "head_teacher_id"
  add_foreign_key "tasks", "students"
  add_foreign_key "tasks", "subjects"
end
