require_relative '../spec_helper'
require_relative '../../lib/engine_route'

module Roots
  describe EngineRoute do
    subject { described_class.new(anything) }

    it 'inherits from Roots::Route' do
      expect(described_class.ancestors).to include(Roots::Route)
    end

    it 'responds to mount=' do
      expect(subject).to respond_to(:mount=)
    end

    it 'responds to mount' do
      expect(subject).to respond_to(:mount)
    end
  end
end
