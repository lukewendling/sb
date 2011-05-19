class SentMail < ActiveRecord::Base
  serialize :serialized_mail
  
  named_scope :incomplete, :conditions => {:complete => false}
end
