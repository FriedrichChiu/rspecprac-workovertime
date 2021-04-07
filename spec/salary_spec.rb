require 'timecop'
require './employee.rb'
require 'pry'

RSpec.describe "Overtime Payment Calculation" do

  context "Overtime on a workday " do
    it do "overtime within 2hrs"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,4,7,12,0,0)) # set a normal work day on calendar
      employee.startwork
      Timecop.freeze(Timecop.travel(60*95)) # preventing minor time lapses => time will start flow again once Time.travel 
      employee.endwork
      expect(employee.paycalc).to be 892
    end

    it do "overtime above 2hrs yet within 4hrs"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,4,7,12,0,0)) 
      employee.startwork
      Timecop.freeze(Timecop.travel(60*225))  
      employee.endwork
      expect(employee.paycalc).to be 2004
    end
  end


  context "Overtime on weekend " do
    it do "overtime within 2hrs"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,4,10,8,0,0)) # set Saturday on calendar
      employee.startwork
      Timecop.freeze(Timecop.travel(60*95))
      employee.endwork
      expect(employee.paycalc).to be 892
    end

    it do "overtime above 2hrs yet within 8hrs"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,4,10,8,0,0)) 
      employee.startwork
      Timecop.freeze(Timecop.travel(60*425)) 
      employee.endwork 
      expect(employee.paycalc).to be 4229
    end

    it do "overtime above 8hrs yet within 12hrs)"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,4,10,8,0,0)) 
      employee.startwork
      Timecop.freeze(Timecop.travel(60*666)) 
      employee.endwork 
      expect(employee.paycalc).to be 7785 
    end
  end


  context "Overtime on days-off or holidays " do
    it do "overtime within 8hrs"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,5,11,8,0,0)) # personal day-off of employee - id# 1
      employee.startwork
      Timecop.freeze(Timecop.travel(60*425))
      employee.endwork
      expect(employee.paycalc).to be 2664
    end

    it do "overtime above 8hrs yet within 10hrs"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,5,11,8,0,0)) 
      employee.startwork
      Timecop.freeze(Timecop.travel(60*545))
      employee.endwork
      expect(employee.paycalc).to be 4222
    end

    it do "overtime above 10hrs yet within 12hrs)"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,5,11,8,0,0)) 
      employee.startwork
      Timecop.freeze(Timecop.travel(60*666))
      employee.endwork
      expect(employee.paycalc).to be 6000
    end
  end


  context "Overtime on days-off or holidays due to emergency" do
    it do "overtime within 8hrs"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,5,12,8,0,0)) # personal day-off of employee - id# 1
      employee.startwork
      Timecop.freeze(Timecop.travel(60*425))
      employee.endwork
      expect(employee.paycalc).to be 5328
    end

    it do "overtime above 8hrs yet within 10hrs"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,5,12,8,0,0)) 
      employee.startwork
      Timecop.freeze(Timecop.travel(60*545))
      employee.endwork
      expect(employee.paycalc).to be 6886
    end

    it do "overtime above 10hrs yet within 12hrs)"
      employee = Employee.new(80000,1)
      Timecop.freeze(Time.new(2021,5,12,8,0,0)) 
      employee.startwork
      Timecop.freeze(Timecop.travel(60*666))
      employee.endwork
      expect(employee.paycalc).to be 8664
    end
  end
end
