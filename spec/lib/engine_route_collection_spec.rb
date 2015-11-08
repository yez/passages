require_relative '../spec_helper'
require_relative '../../lib/engine_route_collection'

module Roots
  describe EngineRouteCollection do
    describe '#initialize' do
      let(:fake_route) { Object.new }

      subject { described_class.new([{ engine: 'Whatever', routes: [fake_route]}]) }

      it 'initializes routes as Roots::Engine' do
        expect(subject.routes).to_not be_empty

        subject.routes.each do |engine_name, engine_hash|
          expect(engine_hash[:routes].all? { |r| r.is_a?(Roots::Route) }).to eq(true)
        end
      end
    end
  end
end
