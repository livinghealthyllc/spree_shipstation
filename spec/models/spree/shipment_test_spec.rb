require 'spec_helper'

describe Spree::Shipment do
  context "between" do
    before do
      @active = []

      @dt1 = dt1 = 2.days.ago
      @dt2 = dt2 = 2.day.from_now

      # order = FactoryGirl.create(:order, updated_at: dt1)
      # @shipment1 = FactoryGirl.create(:shipment, updated_at: dt1, order: order)

      order = create_order(updated_at: dt1)
      # order.updated_at = dt1
      # order.save!
      @shipment1 = create_shipment(updated_at: dt1, order: order)


      # create_shipment(updated_at: dt1, order: create_order(updated_at: dt1))
      # create_shipment(updated_at: dt1, order: create(:order, updated_at: dt1))
      # @shipment1.updated_at = dt1
      # @shipment1.order.updated_at = dt1
      # @shipment1.save!

      # FactoryGirl.create(:shipment, order: FactoryGirl.create(:order).update_attributes(updated_at: dt1, created_at: dt1)).update_attributes(updated_at: dt1, created_at: dt1)
      create_shipment(updated_at: dt2, order: create_order(updated_at: dt2))
      # FactoryGirl.create(:shipment, order: FactoryGirl.create(:order).update_attributes(updated_at: dt2, created_at: dt2)).update_attributes(updated_at: dt2, created_at: dt2)
      # Old shipment thats order was recently updated..

      @active << create_shipment(updated_at: 1.week.ago, order: create_order(updated_at: Time.now))
      # @active << FactoryGirl.create(:shipment, updated_at: 1.week.ago, created_at: 1.week.ago, order: FactoryGirl.create(:order, updated_at: Time.now, created_at: Time.now))
      # New shipments
      # @active << FactoryGirl.create(:shipment, updated_at: Time.now, created_at: Time.now)
      # @active << FactoryGirl.create(:shipment, updated_at: Time.now, created_at: Time.now)
      @active << create_shipment(updated_at: Time.now, order: create_order(updated_at: Time.now))
      @active << create_shipment(updated_at: Time.now, order: create_order(updated_at: Time.now))
      # without_timestamping_of Spree::Shipment, Spree::Order do
      # end
    end

    subject(:shipment1) { Spree::Shipment.first }
    specify { expect(shipment1.updated_at).to eq(@dt1) }
    it "check order date_time" do
      expect(shipment1.order.updated_at).to eq(@dt1)
    end

    subject(:order1) { Spree::Order.first }
    specify { expect(order1.updated_at).to eq(@dt1) }

    # shipment1 = Spree::Shipment.first
    # it "check shipment date_time" do
    #   expect(shipment1.updated_at).to eq(@dt1)
    # end

    # Get new shipments
    from = Time.now - 1.hour
    to = Time.now + 1.hour

    subject(:orders) { Spree::Order.where(updated_at: from..to) }
    specify { expect(orders.size).to eq(3) }

    # subject(:shipments) { Spree::Shipment.where(updated_at: from..to) }
    subject(:shipments) { Spree::Shipment.between(from, to) }
    # shipments = Spree::Shipment.joins(:order).where(updated_at: from..to, spree_orders: { updated_at: from..to } )
    specify { expect(shipments.size).to eq(@active.size) } # check the searching of the active shipments

    subject(:all_shipments) { Spree::Shipment.all }
    specify { expect(all_shipments.size).to eq(5) } # check the total shipments

    subject(:all_orders) { Spree::Order.all }
    specify { expect(all_orders.size).to eq(5) } # check the total shipments

    specify { expect(@active.size).to eq(3) } # check size of the @active shipments

  end

  def without_timestamping_of(*klasses)
    if block_given?
      klasses.delete_if { |klass| !klass.record_timestamps }
      klasses.each { |klass| klass.record_timestamps = false }
      begin
        yield
      ensure
        klasses.each { |klass| klass.record_timestamps = true }
      end
    end
  end

  def create_order(options={})
    FactoryGirl.create(:order, options).tap do |order|
      order.update_column(:updated_at, options[:updated_at]) if options[:updated_at]
      # sleep(1)
      # order.update_attributes(options)# if options[:updated_at]
    end
  end

  def create_shipment(options={})
    FactoryGirl.create(:shipment, options).tap do |shipment|
      shipment.update_column(:state, options[:state]) if options[:state]
      shipment.update_column(:updated_at, options[:updated_at]) if options[:updated_at]
      # sleep(1)
      # shipment.update_attributes(options)
      # shipment.update_attributes(options)
    end
  end

end
