require 'net/ftp'
require 'printing/daily_summary_report'


namespace :reports do
  namespace :daily do
    # rake reports:daily:summary
    task :summary => :environment do
      #
    end
    # rake reports:daily:pdf_summary
    task :pdf_summary => :environment do
      start_time  = (Time.zone.now - 1.day).beginning_of_day
      end_time    = start_time.end_of_day

      report = DailySummaryReport.new
      pdf = report.print_form(start_time, end_time)
      # uncomment to test locally
      # pdf.render_file('prawn.pdf')

      file = StringIO.new(pdf.render) #mimic a real upload file
      file.class.class_eval { attr_accessor :original_filename, :content_type } #add attr's that paperclip needs
      file.original_filename = "my_report.pdf"
      file.content_type = "application/pdf"
      puts 'still good'
      export_doc = ExportDocument.new()
      export_doc.doc = file
      export_doc.export_type_id = ExportType::DAILY_SUMMARY_REPORT_ID
      export_doc.info = "Summary for #{start_time}  to  #{end_time}"
      export_doc.save
      if export_doc.errors.full_messages.blank?
        puts "IT WORKED!"
      else
        puts export_doc.errors.full_messages
      end
    end
  end
end
