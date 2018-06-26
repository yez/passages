require 'spec_helper'
require 'action_dispatch/routing'
require 'rails'

require_relative '../../../lib/passages/engine'
require_relative '../../../app/controllers/passages/routes_controller'

module Passages
  describe RoutesController do
    describe '#routes' do
      before do
        allow(subject).to receive(:application_routes) { [] }
        allow(subject).to receive(:engine_routes) { [] }
        allow(subject).to receive(:mount_routes) { {} }
        subject.routes
      end

      it 'sets @routes' do
        expect(subject.instance_variable_get(:@routes)).to_not be_nil
      end

      it 'sets @engine_routes' do
        expect(subject.instance_variable_get(:@engine_routes)).to_not be_nil
      end

      it 'sets @engine_routes only if a corresponding mounte route exists' do
        first_engine_route = { engine: :foo, routes: [anything] }
        second_engine_route = { engine: :bar, routes: [anything] }
        allow(subject).to receive(:engine_routes) do
          [
            first_engine_route,
            second_engine_route
          ]
        end
        allow(subject).to receive(:mount_routes) { { foo: anything } }
        expected = [first_engine_route]
        subject.routes
        expect(subject.instance_variable_get(:@engine_routes)).to eq(expected)
      end

      it 'sets @mount_routes' do
        expect(subject.instance_variable_get(:@mount_routes)).to_not be_nil
      end
    end

    describe '!#engine_routes' do
      it 'calls mounted_engine_routes' do
        expect(subject).to receive(:mounted_engine_routes) { [] }
        subject.send(:engine_routes)
      end
    end

    describe '!#passages_rails_routes' do
      it 'calls deep into the Rails routes' do
        expect(Rails)
          .to receive_message_chain(:application, :routes, :routes) do
            []
          end
        subject.send(:passages_rails_routes)
      end
    end
  end
end
