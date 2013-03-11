class TalExportSerializer
  require 'builder'

  #attr_accessor :attributes, :order_ids, :order_item_ids

  def initialize()
  end

  def build_xml(order)
    builder = Nokogiri::XML::Builder.new(:encoding => 'utf-8') do |xml|
      xml.order(:version => "2.1") {
        order_header_xml(xml, order)
        order_items = OrderItem.includes([{:customizations => :custom_type}, :easement_profile, :order]).find(order_item_ids)

        order_items.group_by(&:order_id).each do |order_id, items|
          items.each do |item|
            order_xml(xml, order_items, item)
          end
        end
      }
    end
    builder.to_xml
  end

  def order_header_xml(xml, order)
    xml.OrderHeader {
      xml.GROUP_CODE( 'XXXX' )
      xml.DATE_ORD("#{order.display_completed_at(:moulton_date)}")
      xml.CL_NO('XX')
      xml.CSOURCE('TESTING')
      xml.CMEDIA('XXXX')
      xml.CREDCD('4111111111111111')
      xml.EXPDT('0415')
      xml.PROJECT('proj1')
      xml.AMTPAY()
      xml.MICRCODE()
      xml.PAY_TYPE('C')
      xml.NUM_PYMNTS(1)
      xml.EMAIL('test@test12345.com')
      xml.COMPANY()
      xml.F_NAME('JOHN')
      xml.L_NAME('DOE')
      xml.ADDR_1('TESTING')
      xml.ADDR_2('TESTING')
      xml.CITY('TESTING')
      xml.ST('TESTING')
      xml.ZIP('TESTING')
      xml.PHONE('')
      xml.PHONE_EXT('')
      xml.COUNTRY_CODE('US')
      xml.OPT_IN()
      xml.OPT_OUT()
      xml.ADJ_CODE()
      xml.AMT_DISC()
      xml.PURCHASE_ORDER()
      xml.BILL_TO_COMPANY()
      xml.BILL_TO_F_NAME('')
      xml.BILL_TO_L_NAME('')
      xml.BILL_TO_ADDR_1('TESTING')
      xml.BILL_TO_ADDR_2('TESTING')
      xml.BILL_TO_CITY('TESTING')
      xml.BILL_TO_ST('TESTING')
      xml.BILL_TO_ZIP('TESTING')
      xml.BILL_TO_COUNTRY_CODE('TESTING')
      xml.UNIQUE-ID('TESTING')
      xml.HAS_FINANCIAL('Y')
      xml.HAS_GIFT_REC('')
      xml.HAS_CSTM('')
    }
  end
  def order_detail_xml(xml, order)
    xml.OrderDetail {
      xml.LineItem() {
        xml.QUANTITY_ORDERED(1)
        xml.OFFER_CODE('XXXXXX')
      }
    }
  end

  def order_customer_info_xml(xml, order)
    xml.CSTM {
      xml.CUSTOMER-NUMBER()
    }
  end
end
