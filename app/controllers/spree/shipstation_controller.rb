include SpreeShipstation

module Spree
  class ShipstationController < Spree::StoreController
    include Spree::BasicSslAuthentication
    include Spree::DateParamHelper
    layout false

    protect_from_forgery except: :shipnotify

    skip_before_filter :verify_authenticity_token

    def export
      @shipments = Spree::Shipment.exportable.between(
        date_param(:start_date),
        date_param(:end_date))
      .page(params[:page])
      .per(50)
      render "export.xml.builder"
    end

    def shipnotify
      notice = Spree::ShipmentNotice.new(params)

      if notice.apply
        render(text: 'success')
      else
        render(text: notice.error, status: :bad_request)
      end
    end
  end
end
