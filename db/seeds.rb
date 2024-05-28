# frozen_string_literal: true

# db/seeds.rb

# Create teachers

Task.destroy_all
GroupSchedule.destroy_all
GroupSubject.destroy_all
Schedule.destroy_all
Student.destroy_all
Group.destroy_all
SubjectTeacher.destroy_all
Subject.destroy_all
Teacher.destroy_all

teachers = Teacher.create([
  { email: 'dima1@karazin.ua',
    password: 'qwerty123',
    first_name: 'Dima',
    last_name: 'Doe',
    city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima2@karazin.ua',
    password: 'qwerty123',
    first_name: 'John',
    last_name: 'Doe',
    city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima3@karazin.ua',
    password: 'qwerty123',
    first_name: 'Masha',
    last_name: 'Doe',
    city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima4@karazin.ua',
    password: 'qwerty123',
    first_name: 'Jenny',
    last_name: 'Doe',
    city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima5@karazin.ua',
    password: 'qwerty123',
    first_name: 'Jorgie',
    last_name: 'Doe',
    city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima6@karazin.ua',
    password: 'qwerty123',
    first_name: 'Peppa',
    last_name: 'Doe',
    city: 'Kherson',
    country: 'Ukraine' }
])

subjects = Subject.create([
  { name: 'Math', head_teacher: teachers[0] },
  { name: 'Programming', head_teacher: teachers[1] },
  { name: 'History', head_teacher: teachers[2] },
  { name: 'Algorithms', head_teacher: teachers[3] }
])

subjects[0].teachers << teachers[1]
subjects[1].teachers << teachers[2]
subjects[1].teachers << teachers[3]
subjects[2].teachers << teachers[3]
subjects[2].teachers << teachers[4]
subjects[2].teachers << teachers[5]
subjects[3].teachers << teachers[2]
subjects[3].teachers << teachers[4]
subjects[3].teachers << teachers[5]

groups = Group.create([
  { name: 'Group A', head_student: nil },
  { name: 'Group B', head_student: nil },
  { name: 'Group C', head_student: nil },
  { name: 'Group D', head_student: nil }
])

students = Student.create([
  { email: 'dima1@gmail.com', password: 'qwerty123', first_name: 'Dima', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima2@gmail.com', password: 'qwerty123', first_name: 'Alica', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima3@gmail.com', password: 'qwerty123', first_name: 'Jenny', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima4@gmail.com', password: 'qwerty123', first_name: 'Harry', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima5@gmail.com', password: 'qwerty123', first_name: 'Ron', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima6@gmail.com', password: 'qwerty123', first_name: 'Hermiona', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima7@gmail.com', password: 'qwerty123', first_name: 'Hagrid', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima8@gmail.com', password: 'qwerty123', first_name: 'Bet', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima9@gmail.com', password: 'qwerty123', first_name: 'Masha', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima10@gmail.com', password: 'qwerty123', first_name: 'Peppa', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' },
  { email: 'dima11@gmail.com', password: 'qwerty123', first_name: 'Jorgie', last_name: 'Doe', city: 'Kherson',
    country: 'Ukraine' }
])

groups[0].students << students[0]
groups[0].students << students[1]
groups[0].students << students[2]
groups[1].students << students[3]
groups[1].students << students[4]
groups[2].students << students[5]
groups[2].students << students[6]
groups[2].students << students[7]
groups[3].students << students[8]
groups[3].students << students[9]
groups[3].students << students[10]

subjects[0].groups << groups[0]
subjects[0].groups << groups[1]
subjects[1].groups << groups[1]
subjects[0].groups << groups[2]
subjects[1].groups << groups[2]
subjects[2].groups << groups[2]
subjects[0].groups << groups[3]
subjects[1].groups << groups[3]
subjects[2].groups << groups[3]
subjects[3].groups << groups[3]

time = Time.current

schedules = Schedule.create([
  { time:, teacher: teachers[0], subject: teachers[0].subjects.first,
    schedule_type: 'lecture' },
  { time: time + 1.hour, teacher: teachers[1], subject: teachers[1].subjects[0],
    schedule_type: 'practic' },
  { time: time + 2.hours, teacher: teachers[1], subject: teachers[1].subjects[1],
    schedule_type: 'lecture' },
  { time: time + 3.hours, teacher: teachers[2], subject: teachers[2].subjects[0],
    schedule_type: 'practic' },
  { time: time + 4.hours, teacher: teachers[2], subject: teachers[2].subjects[1],
    schedule_type: 'lecture' },
  { time: time + 5.hours, teacher: teachers[2], subject: teachers[2].subjects[2],
    schedule_type: 'practic' },
  { time: time + 6.hours, teacher: teachers[3], subject: teachers[3].subjects[0],
    schedule_type: 'lecture' },
  { time: time + 7.hours, teacher: teachers[3], subject: teachers[3].subjects[1],
    schedule_type: 'practic' },
  { time: time + 8.hours, teacher: teachers[3], subject: teachers[3].subjects[2],
    schedule_type: 'lecture' },
  { time: time + 9.hours, teacher: teachers[4], subject: teachers[4].subjects[0],
    schedule_type: 'practic' }

  # { time: time + 1.months, teacher: teachers[4], subject: teachers[4].subjects[1], schedule_type: 'lecture'},
  # { time: time + 1.months, teacher: teachers[5], subject: teachers[5].subjects[0], schedule_type: 'practic'},
  # { time: time + 3.months, teacher: teachers[5], subject: teachers[5].subjects[1], schedule_type: 'lecture'},

  # { time: time + 4.months, teacher: teachers[0], subject: teachers[0].subjects[0], schedule_type: 'practic'},
  # { time: time + 5.months, teacher: teachers[1], subject: teachers[1].subjects[0], schedule_type: 'lecture'},
  # { time: time + 6.months, teacher: teachers[2], subject: teachers[2].subjects[0], schedule_type: 'practic'},
  # { time: time + 7.months, teacher: teachers[3], subject: teachers[3].subjects[0], schedule_type: 'lecture'},
  # { time: time + 8.months, teacher: teachers[4], subject: teachers[4].subjects[0], schedule_type: 'practic'},
  # { time: time + 9.months, teacher: teachers[5], subject: teachers[5].subjects[0], schedule_type: 'lecture'},
  # { time: time + 1.weeks, teacher: teachers[0], subject: teachers[0].subjects[0], schedule_type: 'practic'},
  # { time: time + 2.weeks, teacher: teachers[1], subject: teachers[1].subjects[0], schedule_type: 'lecture'},
  # { time: time + 3.weeks, teacher: teachers[2], subject: teachers[2].subjects[0], schedule_type: 'practic'},
])

# groups[0].schedules << schedules[0]
# groups[0].schedules << schedules[1]
# groups[0].schedules << schedules[2]
# groups[0].schedules << schedules[3]
# groups[0].schedules << schedules[4]
# groups[0].schedules << schedules[5]
# groups[0].schedules << schedules[6]
# groups[0].schedules << schedules[7]
# groups[0].schedules << schedules[8]
# groups[0].schedules << schedules[9]
# groups[0].schedules << schedules[10]

# groups[0].schedules << schedules[0]
# groups[0].schedules << schedules[0]
# groups[0].schedules << schedules[0]
# groups[0].schedules << schedules[0]
# groups[0].schedules << schedules[0]

schedules[0].groups << groups[0]
schedules[1].groups << groups[0]
schedules[2].groups << groups[0]
schedules[3].groups << groups[0]
schedules[4].groups << groups[0]
schedules[5].groups << groups[0]
schedules[6].groups << groups[0]
schedules[7].groups << groups[0]
schedules[8].groups << groups[0]
schedules[9].groups << groups[0]
# schedules[11].groups << groups[0]
# schedules[12].groups << groups[0]
# schedules[13].groups << groups[0]
# schedules[14].groups << groups[0]
# schedules[15].groups << groups[0]

tasks = Task.create([
  { title: 'Numerical Integration', description: 'Using method...', max_score: 10 },
  { title: 'Numerical Approximation', description: 'Using method...', max_score: 10 },
  { title: 'Numerical Interpolation', description: 'Using method...', max_score: 10 },
  { title: 'Numerical Limination', description: 'Using method...', max_score: 10 },
  { title: 'Numerical Mantigation', description: 'Using method...', max_score: 10 },
  { title: 'Numerical Federation', description: 'Using method...', max_score: 10 }
])

# Assign subjects to tasks
tasks[0].subject = subjects[0]
tasks[1].subject = subjects[1]
tasks[2].subject = subjects[2]
tasks[3].subject = subjects[3]
tasks[4].subject = subjects[0]
tasks[5].subject = subjects[1]

# Assign students to tasks
groups[0].tasks << tasks[0]
# tasks[0].groups << groups[0]
# tasks[1].groups << groups[0]
# tasks[1].groups << groups[1]
# tasks[2].groups << groups[1]
# tasks[2].groups << groups[2]
# tasks[3].groups << groups[0]
# tasks[3].groups << groups[1]
# tasks[3].groups << groups[3]
# tasks[4].groups << groups[1]
# tasks[4].groups << groups[3]
# tasks[3].groups << groups[4]

tasks.each do |task|
  if task.valid?
    task.save
    Rails.logger.debug { "#{task.title} task created successfully." }
  else
    Rails.logger.debug { "Error creating #{task.title} task:" }
    Rails.logger.debug task.errors.full_messages.join(', ')
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
