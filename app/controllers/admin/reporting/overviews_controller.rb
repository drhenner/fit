class Admin::Reporting::OverviewsController < Admin::Reporting::BaseController
  before_filter :set_time_range

  def show
    params[:start_time] if params[:start_time].present?
    @accounting_report  = ROReReports::Accounting.new(start_time, end_time)
    @orders_report      = ROReReports::Orders.new(start_time, end_time)
    @customers_report   = ROReReports::Customers.new(start_time, end_time)
  end

  private

  def set_time_range
    if params[:start_time].present?
      @start_time = Time.parse(params[:start_time])
      @end_time   = params[:start_time].present? ? Time.parse(params[:end_time]) : Time.zone.now
    else
      @start_time, @end_time = ROReReports::Accounting.weekly
    end
  end

  def start_time
    @start_time
  end

  def end_time
    @end_time
  end
end
