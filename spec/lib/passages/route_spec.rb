require_relative '../../spec_helper'
require_relative '../../../lib/passages/route'

module Passages
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

    describe '.from_raw_route' do
      let(:raw_route) { anything }
      before { allow(described_class).to receive(:mount_route_class) { mount_class } }

      context 'mount class is present' do
        let(:mount_class) { anything }
        it 'instantiates and returns a new MountRoute' do
          expect(MountRoute).to receive(:new).with(raw_route, mount_class)
          described_class.from_raw_route(raw_route)
        end
      end

      context 'mount class is nil' do
        let(:mount_class) { nil }
        it 'instantiates and returns a new Route' do
          expect(described_class).to receive(:new).with(raw_route)
          described_class.from_raw_route(raw_route)
        end
      end
    end
  end
end
