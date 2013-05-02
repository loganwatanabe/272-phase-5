class HomeController < ApplicationController

  def index
    @upcoming_tournaments = Tournament.upcoming.next(5).chronological


        @student = Student.find(current_user.student_id)
        registrations = Registration.for_student(@student)
        up_reg = registrations.select{|r| r.section.tournament.date >= Date.current.to_date and (r.section.active ==true)}
    @up_reg_sections = up_reg.map{|r| r.section}.take(5)



      student_sections=Registration.for_student(@student).map{|i| i.section}

      all_eli = Section.for_rank(@student.rank).for_age(@student.age).active.alphabetical.select{|s| student_sections.include?(s) and (s.active == true)}
    @eligible_sec = all_eli.sort_by{|s| s.tournament.date}.take(5)


  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
  end
end
