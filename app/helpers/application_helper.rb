module ApplicationHelper
  def rank_name(rank_id)
    case
    when rank_id == 1
      "Tenth Gup"
    when rank_id == 2
      "Ninth Gup"
    when rank_id == 3
      "Eighth Gup"
    when rank_id == 4
      "Seventh Gup"
    when rank_id == 5
      "Sixth Gup"
    when rank_id == 6
      "Fifth Gup"
    when rank_id == 7
      "Fourth Gup"
    when rank_id == 8
      "Third Gup"
    when rank_id == 9
      "Second Gup"
    when rank_id == 10
      "First Gup"
    when rank_id == 11
      "First Dan"
    when rank_id == 12
      "Second Dan"
    when rank_id == 13
      "Third Dan"
    when rank_id == 14
      "Fourth Dan"
    else
      "Senior Master"
    end
  end
  
  def eligible_students_for_section(section)
    # I want students between a set of ranks, between a set of ages, who are active and have the list arranged in alphabetical order.
    # Thankfully I have methods for all of those which were done and tested last phase, so this task is now super easy...
    students = Student.ranks_between(section.min_rank, section.max_rank).ages_between(section.min_age, section.max_age).active.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def eligible_sections_for_student(student)
    sections = Section.for_rank(student.rank).for_age(student.age).active.alphabetical.paginate(:page => params[:page]).per_page(20)
  end
  
  def eligible_unregistered_students_for_section(section)
    eligible = eligible_students_for_section(section)
    already_registered = section.students
    eligible_unregistered = eligible - already_registered
  end
  
  def age_range_for(section)
    if section.min_age == section.max_age
      "#{section.min_age}"
    elsif section.max_age.nil?
      "#{section.min_age} and up"
    else
      "#{section.min_age} - #{section.max_age}"
    end
  end
  
  def rank_range_for(section)
    if section.min_rank == section.max_rank
      "#{rank_name section.min_rank}"
    elsif section.max_rank.nil?
      "#{rank_name section.min_rank} and up"
    else
      "#{rank_name section.min_rank} - #{rank_name section.max_rank}"
    end
  end

  def registered?(student, section)  #checks to see is a student is already registered for a given section
      student_sections=Registration.for_student(student).map{|i| i.section}
      student_sections.include?(section)
  end


  def section_winner(section)
    registrations = Registration.for_section(section)
    winner = registrations.select{|r| r.final_standing == 1}
    if winner.empty?
      return nil
    else
      winner.each{|r| return r.student} #returns a student
    end
  end

  def dojo_address(dojo)
    return "#{dojo.street} \n #{dojo.city}, #{dojo.state}   #{dojo.zip}"
  end

  
  def activity(variable)
    if variable
      return "Yes"
    else
      return "No"
    end
  end

  def role_name(user)
    roles = [['Administrator', :admin],['Member', :member]]
    if user.role.nil?
      return nil
    elsif user.role == 'admin'
      'Administrator'
    elsif user.role == 'member'
      'Member'
    else
      user.role
    end
  end

  def waiver_name(waiver_signed)  #the same as the method above, but named differently to avoid confusion
    if waiver_signed
      return "Yes"
    else
      return "No"
    end
  end

  
  def max_rank_name(max_rank)   #needed since max_rank and max_age can be nil
    if max_rank
      return rank_name(max_rank)
    else
      return "None"
    end
  end

  def max_age_name(max_age)
    if max_age
      return max_age
    else
      return "None"
    end
  end



  def phone_name(phone)     #formats phone numbers nicely
    area = phone[0..2]
    local = phone[3..5]
    last = phone[6..9]
    return "#{area}-#{local}-#{last}"
  end

  def date_format(date)
    if date.nil?
      "Currently Attending"
    else
      date.strftime("%m/%d/%y")
    end 
  end

  def time_format(time)
    if time.nil?
      "No time set"
    else
      time.strftime("%l:%M %p")
    end 
  end


  def age_range(min, max)   #formats age and rank ranges to pass cucumbers
    if max
     "#{min} - #{max}" 
    else
      "#{min} and up"
    end
  end

  def rank_range(min, max)
    if max
     "#{rank_name(min)} - #{rank_name(max)}"
     else
     "#{rank_name(min)} and higher"
   end
  end


end
