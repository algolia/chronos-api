require 'spec_helper'

describe Chronos do

  describe '.url=' do
    subject { described_class }

    it 'sets new url' do
      described_class.url = 'http://foo'
      expect(described_class.url).to eq('http://foo')

      # reset connection after running this spec
      described_class.url = nil
    end

    it 'resets connection' do
      old_connection = described_class.connection
      described_class.url = 'http://bar'

      expect(described_class.connection).not_to be(old_connection)

      # reset connection after running this spec
      described_class.url = nil
    end
  end

  describe '.options=' do
    subject { described_class }

    it 'sets new options' do
      described_class.options = {:foo => 'bar'}
      expect(described_class.options).to eq({:foo => 'bar'})

      # reset connection after running this spec
      described_class.options = nil
    end

    it 'resets connection' do
      old_connection = described_class.connection
      described_class.options = {:foo => 'bar'}

      expect(described_class.connection).not_to be(old_connection)

      # reset connection after running this spec
      described_class.options = nil
    end

    it 'adds :basic_auth options for :username and :password' do
      described_class.options = {:username => 'user', :password => 'password'}
      expect(described_class.connection.options)
        .to eq({:basic_auth => {:username => 'user', :password => 'password'}})

      # reset connection after running this spec
      described_class.options = nil
    end
  end

end