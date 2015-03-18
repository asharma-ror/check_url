require 'pry'
require 'bundler'

Bundler.require :default, :development

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'check_url'
require 'active_model'
require 'active_support/core_ext/kernel/singleton_class'

RSpec.configure do |c|
  
end