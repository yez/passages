require_relative '../../spec_helper'
require_relative '../../../lib/roots/engine_route'
require_relative '../../../lib/roots/engine_route_collection'

module Roots
  describe EngineRouteCollection do
    describe '#initialize' do
      let(:fake_route) { instance_double(EngineRoute) }
      let(:engine_name) { 'Whatever' }

      before do
        allow(fake_route).to receive(:engine_name) { engine_name }
        allow(fake_route).to receive(:internal?) { false }
      end

      subject { described_class.new([{engine: engine_name, routes: [fake_route]}]) }

      it 'adds the engine name to each route' do
        expect(subject.routes.all? { |route| route[:engine] == engine_name }).to eq(true)
      end
    end
  end
end
