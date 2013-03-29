class TextWorker
  include Sidekiq::Worker

  def perform( args={} )
    client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV["TWILIO_AUTH_TOKEN"])
    args = Hash[args.map{ |k, v| [k.to_sym, v] }] #turns all keys to symbols
    message = client.account.sms.messages.create({:from => args[:from], 
                                                  :to => args[:to],
                                                  :body => args[:body]
                                                  })
    puts "!"*500
    puts args[:text_id]
    Text.find(args[:text_id].to_i).update_attribute(:complete, true)
    puts message
  end

end
