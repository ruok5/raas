# require 'mixlib/shellout'
require 'sinatra'

# reply = Mixlib::ShellOut.new("hailo -b /app/db/reva.sqlite -R")
# random_reply = Mixlib::ShellOut.new("hailo -b /app/db/reva.sqlite -R")
# learn = Mixlib::ShellOut.new("hailo -b /app/db/reva.sqlite -L")

def reply(query)
  `hailo -b /app/db/reva.sqlite -r "#{query}"`
end

def learn(query)
  `hailo -b /app/db/reva.sqlite -L "#{query}"`
end

def random_reply
  `hailo -b /app/db/reva.sqlite -R`
end

set :bind, "0.0.0.0"

get '/' do
  'Hello world!'
end

get '/api/vi/reply' do
  if params['q']
    reply(params['q'])
  else
    "q not found"
  end
end

get '/api/vi/learn' do
  if params['q']
    learn(params['q'])
  else
    "q not found"
  end
end

get '/api/vi/random' do
  random_reply(params['q'])
end