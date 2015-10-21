require_relative '../spec_helper'
require_relative '../../lib/route'

module Roots
  describe Route do
    subject { described_class.new(anything) }

    describe '#initialize' do
      it 'sets the wrapped instance var' do
        expect(subject.instance_variable_get(:@wrapped)).to_not be_nil
      end
    end

    describe '#name' do
      it 'calls name on the wrapped ivar' do
        expect(subject.wrapped).to receive(:name)
        subject.name
      end
    end

    describe '#verb' do
      it 'calls verb on the wrapped ivar' do
        expect(subject.wrapped).to receive(:verb)
        subject.verb
      end
    end

    describe '#controller' do
      it 'calls controller on the wrapped ivar' do
        expect(subject.wrapped).to receive(:controller)
        subject.controller
      end
    end

    describe '#action' do
      it 'calls action on the wrapped ivar' do
        expect(subject.wrapped).to receive(:action)
        subject.action
      end
    end

    describe '#path' do
      it 'calls path on the wrapped ivar' do
        expect(subject.wrapped).to receive(:path)
        subject.path
      end
    end
  end
end
