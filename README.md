chronos-api
============

[![Gem Version](https://badge.fury.io/rb/chronos-api.svg)](http://badge.fury.io/rb/chronos-api) [![travis-ci](https://travis-ci.org/algolia/chronos-api.png?branch=master)](https://travis-ci.org/algolia/chronos-api)

This gem provides a CLI and a simple REST API client for [Chronos](https://github.com/mesos/chronos).

Installation
------------

Add this line to your application's Gemfile:

```ruby
gem 'chronos-api', :require => 'chronos'
```

And then run:

```shell
$ bundle install
```

Usage
-----

If you're running Chronos locally on port 4400, there is no setup to do in Ruby. If you're not or change the path or port,  you'll have to point the gem to your socket or local/remote port. For example:

```ruby
Chronos.url = 'http://example.com:8080'
```

It's possible to use `ENV` variables to configure the endpoint as well:

```shell
$ CHRONOS_URL=http://remote.chronos.example.com:8080 irb
irb(main):001:0> require 'chronos'
=> true
irb(main):002:0> Chronos.url
=> "http://remote.chronos.example.com:8080"
```

## Authentification

You have two options to set authentification if your Chronos API requires it:

```ruby
Chronos.options = {:username => 'your-user-name', :password => 'your-secret-password'}
```

or

```shell
$ export CHRONOS_USER=your-user-name
$ export CHRONOS_PASSWORD=your-secret-password
$ irb
irb(main):001:0> require 'chronos'
=> true
irb(main):002:0> Chronos.options
=> {:username => "your-user-name", :password => "your-secret-password"}
```

or

```shell
$ chronos -c http://USERNAME:PASSWORD@HOST:PORT
```

## List

To list the current scheduled jobs:

```ruby
require 'chronos'
jobs = Chronos.list
```

or

```shell
$ chronos list
```

## Add a job

To add a new job:

```ruby
require 'chronos'
Chronos.add({
  name: 'myjob',
  schedule: 'R10/2012-10-01T05:52:00Z/PT2S',
  epsilon: 'PT15M',
  command: 'echo foobar',
  owner: 'chronos@algolia.com',
  async: false
})
```

or

```shell
$ chronos add --job /path/to/job/details.json
```

## Delete a job

To delete a job:

```ruby
require 'chronos'
Chronos.delete('job_name')
```

or

```shell
$ chronos delete --name job_name
```

## Delete all jobs

To delete all jobs:

```ruby
require 'chronos'
Chronos.delete_all
```

or

```shell
$ chronos delete_all
```

## Manually start a job

To manually start a job:

```ruby
require 'chronos'
Chronos.start('job_name')
```

or

```shell
$ chronos start --name job_name
```

Contributing
------------

Please fork and send pull request.
Make sure to have test cases for your changes.

Credits
-------

This gem has been highly inspired by [marathon-api](https://github.com/otto-de/marathon-api).

License
-------

This program is licensed under the MIT license. See LICENSE for details.
