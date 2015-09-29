require_relative '../../lib/route'

module Roots
  describe Route do
    describe '#initialize' do
      context 'no requirements without a :: exist' do
        it 'raises error' do
          expect do
            described_class.new({})
          end.to raise_error(/Main Route undefined/)
        end
      end
    end
  end
end
