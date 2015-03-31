require 'rubygems/package'
require 'httparty'
require 'json'
require 'uri'

$LOAD_PATH.unshift(File.dirname(__FILE__))

# The top-level module for this gem. It's purpose is to hold global
# configuration variables that are used as defaults in other classes.
module Chronos

  attr_accessor :logger

  require 'chronos/version'
  require 'chronos/error'
  require 'chronos/connection'

  DEFAULT_URL = 'http://localhost:4400'

  # Get the chronos url from environment
  def env_url
    ENV['CHRONOS_URL']
  end

  # Get marathon options from environment
  def env_options
    opts = {}
    opts[:username] = ENV['CHRONOS_USER'] if ENV['CHRONOS_USER']
    opts[:password] = ENV['CHRONOS_PASSWORD'] if ENV['CHRONOS_PASSWORD']
    opts
  end

  # Get the marathon API URL
  def url
    @url ||= env_url || DEFAULT_URL
    @url
  end

  # Get options for connecting to marathon API
  def options
    @options ||= env_options
  end

  # Set a new url
  def url=(new_url)
    @url = new_url
    reset_connection!
  end

  # Set new options
  def options=(new_options)
    @options = env_options.merge(new_options || {})
    reset_connection!
  end

  # Set a new connection
  def connection
    @connection ||= Connection.new(url, options)
  end

  # Reset the connection
  def reset_connection!
    @connection = nil
  end

  # list jobs
  def list
    connection.get('/scheduler/jobs')
  end

  ## add job
  def add(job)
    connection.post('/scheduler/iso8601', nil, body: job)
  end

  # delete job
  def delete(name)
    connection.delete("/scheduler/job/#{URI.encode name}")
  end

  # delete all jobs
  def delete_all
    connection.delete('/scheduler/jobs')
  end

  # start a job
  def start(name)
    connection.put("/scheduler/job/#{URI.encode name}")
  end

  module_function :connection, :env_options, :env_url, :logger, :logger=,
                  :options, :options=, :url, :url= ,:reset_connection!,
                  :list, :add, :delete, :delete_all, :start

end
