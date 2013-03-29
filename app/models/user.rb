class User < ActiveRecord::Base
  has_many :texts, :dependent => :destroy

  def send_text( args = {} )
    args = Hash[args.map{ |k, v| [k.to_sym, v] }] #turns all keys to symbols
    args = {:from => '+14158738769'}.merge(args)

    text = Text.create( :from => args[:from], :to => args[:to], 
                        :body => args[:body], :user_id => self.id )

    if args.schedule == ""
      job_id = TextWorker.perform_async( args )
    else
      job_id = TextWorker.perform_at( args )
    end
    job_id
   

end
