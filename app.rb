require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/count.rb'

set :bind, '192.168.33.10'
set :port, 3000

before do
  if Count.all.size == 0
    Count.create(number: 0)
  end
end

get '/' do
  'こんにちは'
end

get '/count' do
  @number = 0
  Count.all.each do |c|
    @number += c.number
  end
  erb :index
end

post '/plus' do
  count = Count.first
  count.number = count.number + 1
  count.save
  redirect "/count"
end

post '/minus' do
  count = Count.first
  count.number = count.number - 1
  count.save
  redirect "/count"
end
