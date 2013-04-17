require 'printing/main_printer'
module DailySummaryPrinter
  include MainPrinter
  include ActionView::Helpers::NumberHelper

    # pdf = DailySummaryPrinter.print_form(start_time, end_time)
    # pdf.render_file('prawn.pdf')
    # pdf_file = TempFile.open('prawn.pdf')

    # export_doc = ExportDocument.new()
    # export_doc.doc = pdf_file
    # export_doc.info = "Summary for #{start_time}  to  #{end_time}"
    # export_doc.save
    def print_form(start_time = Time.zone.now.beginning_of_day, end_time = Time.zone.now.end_of_day)
      document = Prawn::Document.new do |pdf|
        print_summary_form(pdf, start_time, end_time)
        pdf#.render#_file card_name
      end # end of Prawn::Document.generate
      return document
    end # end of print_form method

    def print_summary_form( pdf, start_time, end_time)
      pdf.text "Hello World"
    end

end
