require_relative '../../lib/formatter'

module Roots
  describe Formatter do
    describe '#initialize' do
      it 'sets the buffer instance variable' do
        expect(subject.instance_variable_get(:@buffer)).to eq([])
      end
    end

    describe '#section' do
      it 'adds the section to the buffer' do
        section = [{ foo: :bar }]
        subject.section(section)
        expect(subject.instance_variable_get(:@buffer)).to_not be_nil
      end
    end
  end
end
