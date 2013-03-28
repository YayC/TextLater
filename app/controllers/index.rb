get '/' do
  
  erb :index
end

post '/text/schedule' do
  texts = 1 + params[:text][:body].length / 160
  if texts > 3
    return "You crazy, that's #{texts} texts at once. Pick up the phone!"
  end

  if texts == 1
    Text.send(params[:text])
    redirect '/'
  else
    body_chars = params[:text][:body].chars.to_a
    texts.times do
      msg = body_chars.shift(160).join("")
      Text.send( :to => params[:text][:to], :body => msg )
    end
    redirect '/'
  end
  
end
