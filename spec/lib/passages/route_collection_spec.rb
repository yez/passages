require_relative '../../spec_helper'
require_relative '../../../lib/passages/route_collection'

module Passages
  describe RouteCollection do
    let(:fake_route) { instance_double(Passages::Route) }

    before do
      allow_any_instance_of(described_class).to receive(:main_app_name) do
        'SomeGreatApp'
      end
      allow(fake_route).to receive(:internal?) { false }
    end

    subject { described_class.new([fake_route]) }

    it 'is behaves like an enumerable' do
      expect(subject.respond_to?(:each)).to eq(true)
    end

    describe '#initialize' do
      subject { described_class.new([fake_route]) }

      it 'sets the @routes variable' do
        expect(subject.instance_variable_get(:@routes)).to_not be_nil
      end

      context 'route is internal' do
        before do
          allow(fake_route).to receive(:internal?) { true }
        end

        it 'does not add it to @routes' do
          expect(subject.routes).to be_empty
        end

        context 'internal and external routes exist' do
          let(:another_fake_route) { instance_double(Passages::Route) }
          subject { described_class.new([fake_route, another_fake_route]) }

          before do
            allow(another_fake_route).to receive(:internal?) { false }
          end

          it 'only adds the external route' do
            expect(subject.routes).to eq([another_fake_route])
          end
        end
      end
    end
  end
end
