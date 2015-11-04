include SpreeShipstation

module Spree
  class ShipstationController < Spree::BaseController
    #include BasicSslAuthentication
    include Spree::DateParamHelper

    skip_before_filter :verify_authenticity_token
    before_filter :authenticate

    def authenticate
      authenticate_or_request_with_http_basic('Authentication Required') do |username, password|
        username == Spree::Config.shipstation_username && password == Spree::Config.shipstation_password
      end
    end

    layout false

    def export
      @shipments = Spree::Shipment.exportable
                           .between(date_param(:start_date),
                                    date_param(:end_date))
                           .page(params[:page])
                           .per(50)
    end

    def shipnotify
      notice = Spree::ShipmentNotice.new(params)

      number = params[:order_number]
      shipment = Spree::Shipment.find_by_number(number)
      if (shipment)
        order = shipment.order
        order.shipment_state = 'shipped'
        order.save!
      end

      if notice.apply
        render(text: 'success')
      else
        render(text: notice.error, status: :bad_request)
      end
    end
  end
end
