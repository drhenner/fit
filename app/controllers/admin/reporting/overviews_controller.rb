#require 'reports/accounting.rb'
class Admin::Reporting::OverviewsController < Admin::Reporting::BaseController

  def show
    start_time, end_time = ROReReports::Accounting.weekly
    @accounting_report = ROReReports::Accounting.new(start_time, end_time)
  end

  private

end
