require_relative '../spec_helper'
require_relative '../../lib/mount_route'

module Roots
  describe MountRoute do
    let(:route) { double()}
    subject { described_class.new(anything) }
    describe '#initialize' do
      it 'sets the route ivar' do
        expect(subject.instance_variable_get(:@route)).to_not be_nil
      end

      it 'sets the wrapped ivar' do
        expect(subject.instance_variable_get(:@wrapped)).to_not be_nil
      end
    end

    [:internal?, :path].each do |method|
      describe "##{ method }" do
        it "calls #{ method } on @wrapped" do
          expect(subject.instance_variable_get(:@wrapped)).to receive(method)
          subject.send(method)
        end
      end
    end
  end
end
