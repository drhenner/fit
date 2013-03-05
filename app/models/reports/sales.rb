require 'chronic'

module Reports
  class Sales
    # Reports::Sales
    def initialize
      #
    end

    def self.daily(day = Date.today - 1.day)

    end

    def self.weekly(week_of = 'last week')
      report_week = Chronic.parse(week_of)
      report_week.beginning_of_week
      report_week.end_of_week
    end
  end
end
