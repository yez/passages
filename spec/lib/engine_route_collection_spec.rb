require_relative '../spec_helper'
require_relative '../../lib/engine_route'
require_relative '../../lib/engine_route_collection'

module Roots
  describe EngineRouteCollection do
    describe '#initialize' do
      let(:fake_route) { instance_double(EngineRoute) }
      let(:engine_name) { 'Whatever' }

      before do
        allow(fake_route).to receive(:engine_name) { engine_name }
      end

      subject { described_class.new([fake_route]) }

      it 'initializes routes as Roots::Engine' do
        expect(subject.routes).to_not be_empty

        expect(subject.routes.all? { |r| r.is_a?(Roots::Route) }).to eq(true)
      end

      it 'adds the engine name to each route' do
        expect(subject.routes.all? { |route| route.engine_name == engine_name }).to eq(true)
      end
    end
  end
end
