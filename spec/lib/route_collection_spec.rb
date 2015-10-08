require_relative '../spec_helper'
require_relative '../../lib/route_collection'

module Roots
  describe RouteCollection do
    before do
      allow_any_instance_of(described_class).to receive(:main_app_name) { 'SomeGreatApp' }
    end

    describe '#initialize' do
      let(:fake_route) do
        Class.new do
          attr_accessor :path, :spec
          def requirements; {}; end
          def internal?;end
        end.new
      end

      subject { described_class.new(app_routes: [fake_route]) }

      it 'sets the @application_routes variable' do
        expect(subject.instance_variable_get(:@application_routes)).to_not be_nil
      end

      it 'wraps the passed in routes in built in wrapper' do
        expect(subject.instance_variable_get(:@application_routes)).to_not be_empty
        expect(
            subject.instance_variable_get(:@application_routes).all? do |route_hash|
              route_hash[:route].is_a?(ActionDispatch::Routing::RouteWrapper)
            end
          ).to eq(true)
      end

      it 'sets the @engine_routes variable' do
        expect(subject.instance_variable_get(:@engine_routes)).to_not be_nil
      end

      context 'engine routes are present' do
        subject { described_class.new(app_routes: [fake_route], eng_routes: [{ engine: 'Whatever', routes: [fake_route]}]) }

        it 'wraps the passed in routes in built in wrapper' do
          expect(subject.instance_variable_get(:@engine_routes)).to_not be_empty
          expect(
              subject.instance_variable_get(:@engine_routes).all? do |route_hash|
                route_hash[:route].is_a?(ActionDispatch::Routing::RouteWrapper)
              end
            ).to eq(true)
        end
      end

      context 'route is internal' do
        before do
          allow_any_instance_of(
            ActionDispatch::Routing::RouteWrapper
            ).to receive(:internal?) { true }
        end

        it 'does not add it to @routes' do
          expect(subject.instance_variable_get(:@application_routes)).to be_empty
        end
      end
    end
  end
end