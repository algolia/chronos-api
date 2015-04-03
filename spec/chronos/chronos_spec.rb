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

  describe '.list' do
    subject { described_class }

    it 'lists jobs', :vcr do
      jobs = described_class.list
      expect(jobs.size).to eq(1)
      expect(jobs[0]['name']).to eq('SAMPLE_JOB1')
    end
  end

  describe '.add' do
    subject { described_class }

    it 'adds a job', :vcr do
      described_class.add({
        schedule: 'R10/2012-10-01T05:52:00Z/PT2S',
        name: 'SAMPLE_JOB1',
        epsilon: 'PT15M',
        command: 'echo FOO',
        owner: 'chronos@algolia.com',
        async: false
      })
    end
  end

  describe '.delete' do
    subject { described_class }

    it 'deletes a job', :vcr do
      described_class.delete('SAMPLE_JOB1')
    end

    it 'raises a 400 if the job to delete doesn\'t exist', :vcr do
      expect {
        described_class.delete('doesnt_exist')
      }.to raise_error(Chronos::Error::ClientError)
    end
  end


  describe '.delete_all' do
    subject { described_class }

    it 'deletes all jobs', :vcr do
      described_class.delete_all
    end
  end

  describe '.start' do
    subject { described_class }

    it 'starts a job', :vcr do
      described_class.start('SAMPLE_JOB1')
    end

    it 'raises a 400 if the jobs to start doesn\'t exist', :vcr do
      expect {
        described_class.start('doesnt_exist')
      }.to raise_error(Chronos::Error::ClientError)
    end
  end
end