require 'mixlib/shellout'
require 'sinatra'

shell = Mixlib::ShellOut.new("")

set :bind, "0.0.0.0"

get '/' do
  'Hello world!'
end