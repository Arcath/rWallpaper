class Message < ActiveRecord::Base
  attr_accessible :title, :body, :startdate, :enddate
end
