class User < ActiveRecord::Base
  has_many :texts, :dependent => :destroy

  def send_text( args = {} )
    args = Hash[args.map{ |k, v| [k.to_sym, v] }] #turns all keys to symbols
    args = {:from => '+14158738769'}.merge(args)

    text = Text.create( :from => args[:from], :to => args[:to], 
                        :body => args[:body], :user_id => self.id )

    args = args.merge({:text_id => text.id})


    if args[:date] == "" && args[:time] == ""
      Rails.logger.info "texting immediately"
      Rails.logger.info "@"*100
      Rails.logger.info args
      job_id = TextWorker.perform_async( args )

    else
      run_at = Time.strptime("#{args[:date]} #{args[:time]}", "%m/%d/%Y %I:%M %p")
      args = args.slice!(:date, :time)
      Rails.logger.info "scheduling text"
      Rails.logger.info "&"*500
      Rails.logger.info args
      job_id = TextWorker.perform_at( run_at, args )
    end
    job_id
  end
   

end
