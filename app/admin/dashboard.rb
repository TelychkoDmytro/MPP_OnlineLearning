# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
# <<<<<<< Updated upstream
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
# =======
    columns do
      column do
        panel "Recent Students" do
          ul do
            Student.order(created_at: :desc).limit(5).map do |student|
              li link_to("#{student.first_name} #{student.last_name}", admin_student_path(student))
            end
          end
        end
      end

      column do
        panel "Recent Teachers" do
          ul do
            Teacher.order(created_at: :desc).limit(5).map do |teacher|
              li link_to("#{teacher.first_name} #{teacher.last_name}", admin_teacher_path(teacher))
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Statistics" do
          div do
            span "Total Students: #{Student.count}"
            br
            span "Total Teachers: #{Teacher.count}"
            br
            span "Total Groups: #{Group.count}"
            br
            span "Total Subjects: #{Subject.count}"
          end
        end
      end

      column do
        panel "Tasks by Subject" do
          div do
            Subject.joins(:tasks).group('subjects.name').count.each do |subject, count|
              span "#{subject}: #{count} tasks"
              br
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Group Schedules" do
          ul do
            GroupSchedule.includes(:group, :schedule).order(created_at: :desc).limit(5).map do |group_schedule|
              li link_to("#{group_schedule.group.name} - #{group_schedule.schedule.schedule_type}", admin_group_schedule_path(group_schedule))
            end
          end
        end
      end

      column do
        panel "Upcoming Schedules" do
          ul do
            Schedule.order(time: :asc).limit(5).map do |schedule|
              li link_to(
                "#{schedule.subject.name} with #{schedule.teacher.first_name} #{schedule.teacher.last_name} on #{schedule.time.strftime('%d %b %Y, %H:%M')}", admin_schedule_path(schedule)
              )
            end
          end
        end
      end
    end
# >>>>>>> Stashed changes
  end
end
