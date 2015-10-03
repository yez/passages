require_relative '../spec_helper'
require_relative '../../lib/route_collection'

module Roots
  describe RouteCollection do
    describe '#initialize' do

      let(:fake_route) do
        Class.new do
          attr_accessor :path, :spec
          def requirements; {}; end
          def internal?;end
        end.new
      end

      subject { described_class.new([fake_route]) }

      it 'sets the @routes variable' do
        expect(subject.instance_variable_get(:@routes)).to_not be_nil
      end

      it 'wraps the passed in routes in built in wrapper' do
        expect(subject.instance_variable_get(:@routes)).to_not be_empty
        expect(
            subject.instance_variable_get(:@routes).all? do |route|
              route.is_a?(ActionDispatch::Routing::RouteWrapper)
            end
          ).to eq(true)
      end

      context 'route is internal' do
        before do
          allow_any_instance_of(
            ActionDispatch::Routing::RouteWrapper
            ).to receive(:internal?) { true }
        end

        it 'does not add it to @routes' do
          expect(subject.instance_variable_get(:@routes)).to be_empty
        end
      end
    end
  end
end
