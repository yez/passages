require_relative '../../spec_helper'
require_relative '../../../lib/roots/route'

module Roots
  describe Route do
    subject { described_class.new(anything) }

    describe '#name' do
      it 'calls name on the __getobj__' do
        expect(subject.__getobj__).to receive(:name)
        subject.name
      end
    end

    describe '#verb' do
      it 'calls verb on the __getobj__' do
        expect(subject.__getobj__).to receive(:verb)
        subject.verb
      end
    end

    describe '#controller' do
      it 'calls controller on the __getobj__' do
        expect(subject.__getobj__).to receive(:controller)
        subject.controller
      end
    end

    describe '#action' do
      it 'calls action on the __getobj__' do
        expect(subject.__getobj__).to receive(:action)
        subject.action
      end
    end

    describe '#path' do
      it 'calls path on the __getobj__' do
        expect(subject.__getobj__).to receive(:path)
        subject.path
      end
    end
  end
end
