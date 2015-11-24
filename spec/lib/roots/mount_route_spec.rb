require_relative '../../spec_helper'
require_relative '../../../lib/roots/mount_route'

module Roots
  describe MountRoute do
    subject { described_class.new(anything, anything) }

    describe '#initialize' do
      it 'sets the @app ivar' do
        expect(subject.instance_variable_get(:@app)).to_not be_nil
      end
    end

    [:internal?, :path].each do |method|
      describe "##{ method }" do
        it "responds to #{ method }" do
          expect(subject).to respond_to(method)
        end
      end
    end
  end
end
