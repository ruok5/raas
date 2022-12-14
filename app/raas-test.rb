# require 'mixlib/shellout'
require 'sinatra'
require 'json'

# reply = Mixlib::ShellOut.new("hailo -b /app/db/reva.sqlite -R")
# random_reply = Mixlib::ShellOut.new("hailo -b /app/db/reva.sqlite -R")
# learn = Mixlib::ShellOut.new("hailo -b /app/db/reva.sqlite -L")

Encoding.default_external = "UTF-8"

def reply(query)
  `hailo -b /app/db/reva.sqlite -r "#{query}"`.force_encoding("utf-8")
end

def learn(query)
  `hailo -b /app/db/reva.sqlite -L "#{query}"`.force_encoding("utf-8")
end

def random_reply
  `hailo -b /app/db/reva.sqlite -R`.force_encoding("utf-8")
end

def str_to_json(str)
  output = { data: str.chomp }
  output.to_json
end

set :bind, "0.0.0.0"

get '/' do
  'Hello world!'
end

get '/api/v1/reply' do
  if params['q']
    str_to_json reply(params['q'])
  else
    "q not found"
  end
end

get '/api/v1/learn' do
  if params['q']
    str_to_json learn(params['q'])
  else
    "q not found"
  end
end

get '/api/v1/random' do
  str_to_json random_reply
end
