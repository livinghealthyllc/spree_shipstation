require 'spec_helper'

describe Spree::Shipment do
  context "between" do
    before do
      @active = []
      dt1 = 1.day.ago
      dt2 = 1.day.from_now

      @order1 = create(:order, updated_at: dt1)
      @shipment1 = create_shipment(updated_at: dt1)
      @shipment1.order = @order1

      @order2 = create(:order, updated_at: dt2)
      @shipment2 = create_shipment(updated_at: dt2)
      @shipment2.order = @order2

      @order_now = create(:order, updated_at: Time.now)
      @shipment3 = create_shipment(updated_at: 1.week.ago)
      @shipment3.order = @order_now

      @shipment4 = create_shipment(updated_at: Time.now)
      # @shipment4.order = @order4

      @shipment5 = create_shipment(updated_at: Time.now)
      # @shipment5.order = @order5

      # Old shipment thats order was recently updated..
      @active << @shipment3
      # New shipments
      @active << @shipment4
      @active << @shipment5
    end

    # Get new shipments
    from = Time.now - 1.hour
    to = Time.now + 1.hour

    subject(:orders) { Spree::Order.where(updated_at: from..to) }
    specify { expect(orders.size).to eq(3) } # last orders


    subject(:shipments) { Spree::Shipment.between(from, to) }
    # shipments = Spree::Shipment.joins(:order).where(updated_at: from..to, spree_orders: { updated_at: from..to } )
    specify { expect(shipments.size).to eq(@active.size) } # check the searching of the active shipments

    subject(:all_shipments) { Spree::Shipment.all }
    specify { expect(all_shipments.size).to eq(5) } # check the total shipments
    specify { expect(@active.size).to eq(3) } # check size of the @active shipments

    shipments2 = Spree::Shipment.where(updated_at: from..to)
    specify { expect(shipments2.size).to eq(@active.size) } # check the searching of the active shipments
    #
    # subject { Spree::Shipment.between(Time.now-1.hour, Time.now + 1.hours) }
    #
    # # specify { should have(3).shipment }
    # # specify { expect(subject.size).to eq(3) }
    #
    # # specify { should == @active }
    # # specify { expect(subject).to eql(@active) }
    # specify { expect(subject.sort).to eql(@active.sort) }
    # specify { expect(subject).to match_array(@active) }

  end

  context "exportable" do
    let!(:pending) { create_shipment(state: 'pending') }
    let!(:ready)   { create_shipment(state: 'ready')   }
    let!(:shipped) { create_shipment(state: 'shipped') }

    subject { Spree::Shipment.exportable }

    # specify { should have(2).shipments }
    specify { expect(subject.count).to eq(2) }

    specify { should include(ready)}
    specify { should include(shipped)}

    specify { should_not include(pending)}
  end

  context "shipped_email" do
    let(:shipment) { create_shipment(state: 'ready') }

    context "enabled" do
      it "sends email" do
        Spree::Config.send_shipped_email = true
        mail_message = double "Mail::Message"
        Spree::ShipmentMailer.should_receive(:shipped_email).with(shipment).and_return mail_message
        mail_message.should_receive :deliver
        shipment.ship!
      end
    end

    context "disabled" do
      it "doesnt send email" do
        Spree::Config.send_shipped_email = false
        Spree::ShipmentMailer.should_not_receive(:shipped_email)
        shipment.ship!
      end
    end
  end

  def create_shipment(options={})
    # Spree::Shipment.create(updated_at: Time.now)
    FactoryGirl.create(:shipment, options).tap do |shipment|
      shipment.update_column(:state, options[:state]) if options[:state]
      shipment.update_column(:updated_at, options[:updated_at]) if options[:updated_at]
    end
  end

end
