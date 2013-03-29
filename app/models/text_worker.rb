class TextWorker
  include Sidekiq::Worker

  def perform( args={} )
    client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV["TWILIO_AUTH_TOKEN"])
    message = client.account.sms.messages.create({:from => args[:from], 
                                                  :to => args[:to],
                                                  :body => args[:body]
                                                  })
    puts message
  end

  end

end
