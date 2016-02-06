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

The `Core` project is just a dummy project that depends on `DemoLogger`. The only files of interest are:

* spec/e2e/core/lib/core.rb
* spec/e2e/core/spec/unit/core_spec.rb

