require 'spec_helper'
require 'action_dispatch/routing'
require 'rails'

require_relative '../../../lib/passages/engine'
require_relative '../../../app/controllers/passages/routes_controller'

module Passages
  describe RoutesController do
    describe '#routes' do
      before do
        allow(subject).to receive(:application_routes) { anything }
        allow(subject).to receive(:engine_routes) { anything }
        allow(subject).to receive(:mount_routes) { anything }
        subject.routes
      end

      it 'sets @routes' do
        expect(subject.instance_variable_get(:@routes)).to_not be_nil
      end

      it 'sets @engine_routes' do
        expect(subject.instance_variable_get(:@engine_routes)).to_not be_nil
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
