require './all_employee.rb'
require 'time'
require 'timecop'

class Employee < AllEmployee
  attr_reader :personaldaysoff, :hrsalary, :workstart, :dateoftoday, :workend, :totalworkhrs, :holidays, :weekend, :emergency

  def initialize(msalary,id)
    @hrsalary = (msalary/30.0/8.0).round(0)
    @personaldaysoff = @@record[id][:days_off]  #休假日（特休）
    @holidays = ["2021/06/12","2021/06/13","2021/06/14"] #休假日(國定假日)
    @weekend = ["2021/04/10","2021/04/11","2021/04/17","2021/04/18"] #休息日（例假日)
    @emergency = ["2021/05/12"] #事變或突發事變
  end

  def startwork
    @workstart = Time.now
    @dateoftoday = @workstart.strftime("%Y/%m/%d")
  end

  def endwork
    @workend = Time.now
    @totalworkhrs = ((@workend - @workstart)/3600).ceil
  end

  def paycalc
    case @workstart.wday  
    when 1,2,3,4,5
      case
      when (@holidays.include?(@dateoftoday) == true || @personaldaysoff.include?(@dateoftoday) == true ) && (@emergency.include?(@dateoftoday) == false)
        case @totalworkhrs
        when 0..8 then (@hrsalary * 8).round(0)
        when 8..10 then (@hrsalary * 8).round(0) + (@hrsalary * (@totalworkhrs - 8) * 2.34).round(0)
        when 10..12 then (@hrsalary * 8).round(0) + (@hrsalary * 2 * 2.34).round(0) + (@hrsalary * (@totalworkhrs - 10) * 2.67).round(0) 
        else 'Against the Labor Law 1!!! '
        end
      when @holidays.include?(@dateoftoday) == true && @emergency.include?(@dateoftoday) == true 
        case @totalworkhrs
        when 0..8 then (@hrsalary * 8 * 2).round(0)
        when 8..10 then (@hrsalary * 8 * 2).round(0) + (@hrsalary * (@totalworkhrs - 8) * 2.34).round(0)
        when 10..12 then (@hrsalary * 8 * 2).round(0) + (@hrsalary * 2 * 2.34).round(0) + (@hrsalary * (@totalworkhrs - 10) * 2.67).round(0)
        else 'Against the Labor Law 2!!! '
        end
      when @personaldaysoff.include?(@dateoftoday) == true && @emergency.include?(@dateoftoday) == true
        case @totalworkhrs
        when 0..8 then (@hrsalary * 8 * 2).round(0)
        when 8..10 then (@hrsalary * 8 * 2).round(0) + (@hrsalary * (@totalworkhrs - 8) * 2.34).round(0)
        when 10..12 then (@hrsalary * 8 * 2).round(0) + (@hrsalary * 2 * 2.34).round(0) + (@hrsalary * (@totalworkhrs - 10) * 2.67).round(0)
        else 'Against the Labor Law 3!!! '
        end
      else
        case @totalworkhrs 
        when 0..2 then (@hrsalary * @totalworkhrs * 1.34).round(0)
        when 2..4 then (@hrsalary * 2 * 1.34).round(0) + (@hrsalary * (@totalworkhrs - 2) * 1.67).round(0)
        else 'Against the Labor Law 4!!!!'
        end
      end
    when 6,0
      case 
      when (@holidays.include?(@dateoftoday) == true ) && (@emergency.include?(dateoftoday) == false)
        case @totalworkhrs
        when 0..8 then (@hrsalary * 8 * 2).round(0)
        when 8..10 then (@hrsalary * 8 * 2).round(0) + (@hrsalary * (@totalworkhrs - 8) * 2.34).round(0)
        when 10..12 then (@hrsalary * 8 * 2).round(0) + (@hrsalary * 2 * 2.34).round(0) + (@hrsalary * (@totalworkhrs - 10) * 2.67).round(0) 
        else 'Against the Labor Law 5!!! '
        end
      when (@holidays.include?(@dateoftoday) == true ) && (@emergency.include?(dateoftoday) == true)
        case @totalworkhrs
        when 0..8 then (@hrsalary * 8 * 2).round(0)
        when 8..10 then (@hrsalary * 8 * 2).round(0) + (@hrsalary * (@totalworkhrs - 8) * 2.34).round(0)
        when 10..12 then (@hrsalary * 8 * 2).round(0) + (@hrsalary * 2 * 2.34).round(0) + (@hrsalary * (@totalworkhrs - 10) * 2.67).round(0)
        else 'Against the Labor Law 6!!! '
        end
      else
        case @totalworkhrs
        when 0..2 then (@hrsalary * @totalworkhrs * 1.34).round(0)
        when 2..8 then (@hrsalary * 2 * 1.34).round(0) + (@hrsalary * (@totalworkhrs - 2) * 1.67).round(0)
        when 8..12 then (@hrsalary * 2 * 1.34).round(0) + (@hrsalary * 6 * 1.67).round(0) + (@hrsalary * (@totalworkhrs - 8) * 2.67).round(0)
        else "Against the Labor Law 7!!! " 
        end
      end
    else
      "Agreement to be reached between Employer and Employee"
    end
  end
end