require_relative '../../spec_helper'
require_relative '../../../lib/passages/engine_route'
require_relative '../../../lib/passages/engine_route_collection'

module Passages
  describe EngineRouteCollection do
    describe '#initialize' do
      let(:fake_route) { instance_double(EngineRoute) }
      let(:engine_name) { 'Whatever' }

      before do
        allow(fake_route).to receive(:engine_name) { engine_name }
        allow(fake_route).to receive(:internal?) { false }
      end

      subject do
        described_class.new([{ engine: engine_name, routes: [fake_route] }])
      end

      it 'adds the engine name to each route' do
        expect(subject.routes).to be_all do |route|
          route[:engine] == engine_name
        end
      end

      context 'all an engine\'s routes are internal' do
        it 'does not add it to the ivar' do
          allow(fake_route).to receive(:internal?) { true }
          expect(subject.routes).to be_empty
        end
      end

      context 'only some of an engine\'s routes are internal' do
        subject do
          described_class.new([{ engine: engine_name, routes: routes }])
        end
        let(:another_fake_route) do
          instance_double(EngineRoute, internal?: false)
        end
        let(:routes) { [fake_route, another_fake_route] }

        it 'adds the engine to the ivar' do
          expect(subject.routes).to_not be_empty
          expect(subject.routes).to be_all do |r|
            r[:engine] == engine_name
          end
          expect(subject.routes.first[:routes]).to eq(routes)
        end
      end
    end
  end
end
