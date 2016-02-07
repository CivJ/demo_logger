[![Build Status](https://travis-ci.org/CivJ/demo_logger.svg?branch=zen_hw)](https://travis-ci.org/CivJ/demo_logger)

# demo_logger

This logging library layers additional features on top of Ruby's [logger](http://ruby-doc.org/stdlib-2.2.3/libdoc/logger/rdoc/Logger.html)

## Installation

Add this line to your application's Gemfile:

    gem 'demo_logger'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install demo_logger

## Building
See tasks: `bundle exec rake -T`

Full build: `bundle exec rake full_build`

Tests only: `bundle exec rake spec`

## Usage

```
require 'demo_logger'
logger = DemoLogger::DemoLogger.new
```

## Design Overview
I use a `MultiLogger` class to dispatch messages to `FileLogger`, `StdoutLogger` and `EmailLogger`. Each of these
classes depends on Ruby's built in `Logger` class. The logic is pretty simple, each class will always relieve all
the logging calls, but will ignore or execute them according to their configuration. Please see `lib/demo_logger` 
for the implementation. Tests are located at `spec/`.
    
    
## Configuration

Configuration is provided via [clean_config](https://github.com/opower/clean_config), an open source library I wrote.
Please see that project's README for details on how configuration works.

A basic example is

```
# <your-top-level-project>/config/config.yml <-- this location is required
:demo_logger:
  :level: info
```
    
## E2E tests
The tests at `spec/e2e/core/spec/unit` show what happens when you actually include this as a separate library
into a new project. That is the appropriate location to test config value overrides and 'require' statements. Those
tests should guarantee this project will work as expected from another project. 

The `Core` project is just a dummy project that depends on `demo-logger`. The only files of interest are:

* spec/e2e/core/lib/core.rb
* spec/e2e/core/spec/unit/core_spec.rb

## TODOs
Most of the obvious improvements that I am intentionally omitting are marked with TODO. 

### Other omissions given that this is an interview question
* Actually sending email: It should be easy to plug this in. Let's talk about it!
* Integrating with a log aggregator (e.g. Logstash, Splunk)
* Making everything configurable
* Aging log files (the underlying library supports this)
