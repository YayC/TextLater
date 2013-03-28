class Text < ActiveRecord::Base
  
  def self.send(args = {})
    args = Hash[args.map{ |k, v| [k.to_sym, v] }]
    args = {:from => '+14158738769'}.merge(args)
    client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV["TWILIO_AUTH_TOKEN"])
    message = client.account.sms.messages.create({:from => args[:from], 
                                                  :to => args[:to],
                                                  :body => args[:body]
                                                  })
    puts message
  end

end
