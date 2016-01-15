require 'spec_helper'

describe Passages do
  describe '.username' do
    context 'when the ENV variable is set' do
      let(:username) { 'thisisausername' }
      before do
        allow(ENV).to receive(:[]).with('passages_username') { username }
      end

      it 'uses the ENV var' do
        expect(described_class.username).to eq(username)
      end

      context 'uppercase' do
        let(:upper_username) { 'THISISANUPPERUSERNAME' }
        before do
          allow(ENV).to receive(:[]).with('passages_username') { nil }
          allow(ENV).to receive(:[]).with('PASSAGES_USERNAME') { upper_username }
        end

        it 'uses the ENV var' do
          expect(described_class.username).to eq(upper_username)
        end
      end
    end

    context 'when the ENV variable is not set' do
      it 'uses the default value' do
        expect(described_class.username).to eq('username')
      end
    end
  end

  describe '.password' do
    context 'when the ENV variable is set' do
      let(:password) { 'thisisapassword' }
      before do
        allow(ENV).to receive(:[]).with('passages_password') { password }
      end

      it 'uses the ENV var' do
        expect(described_class.password).to eq(password)
      end

      context 'uppercase' do
        let(:upper_password) { 'THISISANUPPERPASSWORD' }
        before do
          allow(ENV).to receive(:[]).with('passages_password') { nil }
          allow(ENV).to receive(:[]).with('PASSAGES_PASSWORD') { upper_password }
        end

        it 'uses the ENV var' do
          expect(described_class.password).to eq(upper_password)
        end
      end
    end

    context 'when the ENV variable is not set' do
      it 'uses the default value' do
        expect(described_class.password).to eq('password')
      end
    end
  end

  describe '.no_auth?' do
    context '@basic_auth is a truthy value' do
      [true, 'yes', ['1'], { a: :b }].each do |value|
        it "#{ value } returns true" do
          described_class.no_auth = value
          expect(described_class.no_auth?).to eq(true)
        end
      end
    end

    context '@basic_auth is a falsey value' do
      [false, nil].each do |value|
        it "#{ value } returns false" do
          described_class.no_auth = value
          expect(described_class.no_auth?).to eq(false)
        end
      end
    end
  end

  describe '.no_auth=' do
    it 'sets the @no_auth var to the passed in value' do
      value = 'foo'
      described_class.no_auth = value

      expect(described_class.instance_variable_get(:@no_auth)).to eq(value)
    end
  end
end
