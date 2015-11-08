require_relative '../spec_helper'
require_relative '../../lib/route_collection'

module Roots
  describe RouteCollection do
    before do
      allow_any_instance_of(described_class).to receive(:main_app_name) { 'SomeGreatApp' }
    end

    describe '#initialize' do
      let(:fake_route) { Object.new }

      subject { described_class.new([fake_route]) }

      it 'sets the @routes variable' do
        expect(subject.instance_variable_get(:@routes)).to_not be_nil
      end

      it 'creates Roots::Routes for each passed in route' do
        expect(subject.routes).to_not be_empty

        expect(subject.routes.all? { |r| r.is_a?(Roots::Route) }).to eq(true)
      end

      context 'route is internal' do
        before do
          allow_any_instance_of(
            ActionDispatch::Routing::RouteWrapper
            ).to receive(:internal?) { true }
        end

        it 'does not add it to @routes' do
          expect(subject.routes).to be_empty
        end
      end
    end
  end
end
