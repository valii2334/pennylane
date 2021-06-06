class ConvertStringToDuration
  def initialize(duration_as_string)
    @duration_as_string = duration_as_string
  end

  def duration_as_integer
    duration_parts = @duration_as_string.gsub('min', 'm')
                                        .gsub('sec','s')
                                        .split(/(?<=[j.h.m.s])\s*/)

    duration = 0

    previous_duration_symbol = nil

    duration_parts.each do |duration_part|
      case duration_part.tr('^a-z', '')
      when 'j'
        duration += duration_part.to_i.days
      when 'h'
        duration += duration_part.to_i.hours
      when 'm'
        duration += duration_part.to_i.minutes
      when 's'
        duration += duration_part.to_i
      else
        case previous_duration_symbol
        when 'j'
          duration += duration_part.to_i.hours
        when 'h'
          duration += duration_part.to_i.minutes
        when 'm'
          duration += duration_part.to_i
        else

        end
      end

      previous_duration_symbol = duration_part.tr('^a-z', '')
    end

    duration.to_i
  end
end
