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
    end

    context 'when the ENV variable is not set' do
      it 'uses the default value' do
        expect(described_class.password).to eq('password')
      end
    end
  end
end
