require 'sinatra'

class SampleApp < Sinatra::Base
  post '/users' do
  end
  post '/users/:user_id/messages' do
  end
  get '/users/:user_id' do
  end
  get '/users/:user_id/messages' do
  end
  get '/users/:user_id/messages/:message_id' do
  end
  put '/users/:user_id/messages/:message_id' do
  end
  put '/users/:user_id' do
  end
  delete '/users/:user_id' do
  end
end
