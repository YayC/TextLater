get '/' do
  
  erb :index
end

post '/text/schedule' do
  p params[:text]
  
  Text.send(params[:text])
  redirect '/'
end
