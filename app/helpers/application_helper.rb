module ApplicationHelper
  def humanize_date_range date_start, date_end
    return "" unless date_start && date_end

    date_to_show = [:Y, :m, :d]
    time_to_show = [:H, :M]

    date_to_show.delete(:Y) if date_start.year == date_end.year
    date_to_show.delete(:m) if date_start.month == date_end.month
    date_to_show.delete(:d) if date_start.day == date_end.day
    time_to_show.delete(:H) if date_start.hour == date_end.hour
    time_to_show.delete(:M) if date_start.min == date_end.min
    Rails.logger.debug "Date to show: #{date_to_show}"
    Rails.logger.debug "Time to show: #{time_to_show}"
    if time_to_show.empty? and date_to_show.empty?
      return "#{date_start.strftime('%d.%m.%Y')} in #{date_start.strftime('%H:%M')}"
    elsif date_to_show.empty?
      return "From #{date_start.strftime('%H:%M')} till #{date_end.strftime('%H:%M')} #{date_end.strftime('%d.%m.%Y')}"
    elsif date_to_show.size == 1 and time_to_show.empty? and date_to_show.index(:d)
      return "From #{date_start.strftime('%d')} till #{date_end.strftime('%d')} #{date_start.strftime('%b %Y')}"
    elsif time_to_show.empty? 
      return "From #{date_start.strftime('%d.%m.%Y')} till #{date_end.strftime('%d.%m.%Y')}"
    else
      return "C #{date_start.strftime('%d.%m.%Y %H:%M')} по #{date_end.strftime('%d.%m.%Y %H:%M')}"
    end
  end
end
