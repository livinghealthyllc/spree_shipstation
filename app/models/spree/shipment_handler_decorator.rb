module SpreeShipstation::ShipmentHandlerDecorator
  def self.included(base)
    base.prepend(InstanceMethods)
  end

  module InstanceMethods

    private

      def send_shipped_email
        Spree::ShipmentMailer.shipped_email(@shipment.id).deliver_later if Spree::Config.send_shipped_email
      end

  end
end

Spree::ShipmentHandler.include SpreeShipstation::ShipmentHandlerDecorator
