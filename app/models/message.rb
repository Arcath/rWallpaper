class Message < ActiveRecord::Base
    def self.to_show
        t=Time.now
        Message.find(:all, :conditions => ["startdate <= ? AND enddate >= ?",t,t])
    end
end
