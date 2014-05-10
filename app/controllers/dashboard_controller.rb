class DashboardController < ApplicationController
  def show
    @upcoming_workshops = Sessions.upcoming
    @next_course = Course.next
    @sponsors = Sponsor.all.shuffle
    @latest_sponsors = Sponsor.latest
    @meeting = Meeting.next
  end

  def code
  end

  def faq
  end

  def about
  end

  def wall_of_fame
    sessions_count = Sessions.count
    @coaches = order_by_attendance(attendance_stats_by_coach).map do |member_id, attendances|
      member = Member.unscoped.find(member_id)
      member.attendance = attendances
      member
    end
  end

  private

  def attendance_stats_by_coach
    SessionInvitation.to_coaches.attended.by_member.count(:member_id)
  end

  def order_by_attendance member_stats
    member_stats.sort_by { |member_id, attendance| attendance }.reverse
  end
end
