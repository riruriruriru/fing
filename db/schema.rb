# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_10_142936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.date "start"
    t.date "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "groupId"
    t.text "description"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "annotations", force: :cascade do |t|
    t.text "comment"
    t.time "times"
    t.bigint "user_id"
    t.bigint "tutorial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tutorial_id"], name: "index_annotations_on_tutorial_id"
    t.index ["user_id"], name: "index_annotations_on_user_id"
  end

  create_table "careers", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_careers_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "academic_unit_id"
    t.index ["academic_unit_id"], name: "index_departments_on_academic_unit_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statusannotations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_tutorials", force: :cascade do |t|
    t.boolean "present"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.bigint "tutorial_id"
    t.index ["student_id"], name: "index_student_tutorials_on_student_id"
    t.index ["tutorial_id"], name: "index_student_tutorials_on_tutorial_id"
  end

  create_table "studentannotations", force: :cascade do |t|
    t.date "times"
    t.text "comment"
    t.bigint "statusannotation_id"
    t.bigint "typeannotation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.integer "derivation"
    t.index ["statusannotation_id"], name: "index_studentannotations_on_statusannotation_id"
    t.index ["student_id"], name: "index_studentannotations_on_student_id"
    t.index ["typeannotation_id"], name: "index_studentannotations_on_typeannotation_id"
    t.index ["user_id"], name: "index_studentannotations_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "rut"
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.integer "careercode"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dv"
    t.string "lastnamema"
    t.boolean "status"
    t.integer "entry"
    t.bigint "department_id"
    t.index ["department_id"], name: "index_students_on_department_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tutor_tutorials", force: :cascade do |t|
    t.boolean "present"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tutor_id"
    t.bigint "tutorial_id"
    t.index ["tutor_id"], name: "index_tutor_tutorials_on_tutor_id"
    t.index ["tutorial_id"], name: "index_tutor_tutorials_on_tutorial_id"
  end

  create_table "tutorials", force: :cascade do |t|
    t.integer "subject"
    t.text "contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "dates"
    t.string "title"
    t.date "start"
    t.date "end"
    t.time "timestart"
    t.time "timeend"
  end

  create_table "tutors", force: :cascade do |t|
    t.integer "rut"
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.integer "phone"
    t.integer "level"
    t.integer "careercode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lastnamema"
    t.string "dv"
    t.boolean "status"
    t.bigint "department_id"
    t.index ["department_id"], name: "index_tutors_on_department_id"
  end

  create_table "typeannotations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "typetutorials", force: :cascade do |t|
    t.bigint "type_id"
    t.bigint "tutorial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tutorial_id"], name: "index_typetutorials_on_tutorial_id"
    t.index ["type_id"], name: "index_typetutorials_on_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rolesdevise"
    t.string "firstname"
    t.string "lastname"
    t.bigint "role_id"
    t.bigint "department_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "annotations", "tutorials"
  add_foreign_key "annotations", "users"
  add_foreign_key "careers", "departments"
  add_foreign_key "departments", "academic_units"
  add_foreign_key "student_tutorials", "students", on_delete: :cascade
  add_foreign_key "student_tutorials", "tutorials", on_delete: :cascade
  add_foreign_key "studentannotations", "statusannotations"
  add_foreign_key "studentannotations", "students", on_delete: :cascade
  add_foreign_key "studentannotations", "typeannotations"
  add_foreign_key "studentannotations", "users"
  add_foreign_key "students", "departments"
  add_foreign_key "tutor_tutorials", "tutorials", on_delete: :cascade
  add_foreign_key "tutor_tutorials", "tutors", on_delete: :cascade
  add_foreign_key "tutors", "departments"
  add_foreign_key "typetutorials", "tutorials"
  add_foreign_key "typetutorials", "types"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "roles", on_delete: :nullify
end
