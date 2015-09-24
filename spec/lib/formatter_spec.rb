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
        section = 'this is a section'
        subject.section(section)
        expect(subject.instance_variable_get(:@buffer)).to include(section)
      end
    end
  end
end
