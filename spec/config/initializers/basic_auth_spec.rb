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
    let(:value) { nil }

    before do
      Passages.config.no_auth = value
    end

    context 'Passages.config is set to true' do
      let(:value) { true }

      it 'returns true' do
        expect(described_class.no_auth?).to eq(true)
      end
    end

    context 'Passages.config is set to false' do
      let(:value) { false }

      it 'returns false' do
        expect(described_class.no_auth?).to eq(false)
      end
    end
  end
end
