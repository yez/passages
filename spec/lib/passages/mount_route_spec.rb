require_relative '../../spec_helper'
require_relative '../../../lib/passages/mount_route'

module Passages
  describe MountRoute do
    subject { described_class.new(anything, anything) }

    describe '#initialize' do
      it 'sets the @app ivar' do
        expect(subject.instance_variable_get(:@app)).to_not be_nil
      end
    end

    describe '#engine_name' do
      it 'calls name on the app ivar' do
        expect(subject.instance_variable_get(:@app)).to receive(:name)
        subject.engine_name
      end
    end

    [:internal?, :path].each do |method|
      describe "##{method}" do
        it "responds to #{method}" do
          expect(subject).to respond_to(method)
        end
      end
    end
  end
end
