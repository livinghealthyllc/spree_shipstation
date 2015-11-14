require 'spec_helper'
# require 'factory_girl_rails'

describe Spree::Shipment do
  context "between" do
    before do
      @active = []
      @users = []
      #
      # user = FactoryGirl.create(:user, :head_buster)
      # @users << user

      create_shipment(updated_at: 2.day.ago, order: create(:order, updated_at: 2.day.ago))
      create_shipment(updated_at: 2.day.from_now, order: create(:order, updated_at: 2.day.from_now))
    
      # Old shipment thats order was recently updated..
      @active << create_shipment(updated_at: 1.week.ago, order: create(:order, updated_at: Time.now))
      # New shipments
      @active << create_shipment(updated_at: Time.now)
      @active << create_shipment(updated_at: Time.now)
      @orders = []
      @orders << create(:order, updated_at: Time.now)

      # ["QM","CDC","SI","QS"].each do |n|
      FactoryGirl.create(:grau, nome: "QM")
      # end
    end

    # specify { expect(@users.count).to eq(1) }



    # Get new shipments
    from = Time.now - 1.minute
    to = Time.now + 1.minute

    orders = Spree::Order.where(updated_at: from..to)
    specify { expect(orders.size).to eq(3) }
    specify { expect(@orders.size).to eq(1) }

    shipments = Spree::Shipment.between(from, to)
    # shipments = Spree::Shipment.joins(:order).where(updated_at: from..to, spree_orders: { updated_at: from..to } )
    specify { expect(shipments.size).to eq(@active.size) } # check the searching of the active shipments

    all_shipments = Spree::Shipment.all
    specify { expect(all_shipments.size).to eq(5) } # check the total shipments
    specify { expect(@active.size).to eq(3) } # check size of the @active shipments


    # subject { Spree::Shipment.between(Time.now-1.hour, Time.now + 1.hours) }
    #
    # # specify { should have(3).shipment }
    # # specify { expect(subject.size).to eq(3) }
    # specify { expect(subject.size).to include(3) }
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
        mail_message = mock "Mail::Message"
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
      # shipment.update_column(:order, options[:order]) if options[:order]
      # if options[:order]
      #     shipment.order = create(:order, updated_at:Time.now)
      #     shipment.save!
      # end
    end
  end

end
