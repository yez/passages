require 'spec_helper'

module Passages
  describe Config do
    describe '#no_auth?' do
      context '@no_auth is a truthy value' do
        [true, 'yes', ['1'], { a: :b }].each do |value|
          it "#{value} returns true" do
            Passages.config.no_auth = value
            expect(Passages.config.no_auth?).to eq(true)
          end
        end
      end

      context '@no_auth is a falsey value' do
        [false, nil].each do |value|
          it "#{value} returns false" do
            Passages.config.no_auth = value
            expect(Passages.config.no_auth?).to eq(false)
          end
        end
      end
    end
  end
end
