class Challenge < ActiveRecord::Base
  belongs_to :challenger, :class_name => 'Friend'
  belongs_to :challenged, :class_name => 'Friend'
  belongs_to :winner, :class_name => 'Friend'
  belongs_to :event

  has_many :comments, :class_name => 'ChallengeComment', :order => 'created_at desc'
  
  validates_presence_of :challenger, :challenged, :hashed_id, :prediction
  
  attr_protected :hashed_id
  
  
  def before_validation_on_create
    super
    self.hashed_id = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
  
  def after_create
    super
    @new_challenge = true # flag to halt update notification
    ChallengeMailer.deliver_the_challenge(self)
    challenger.client.update("#{AppConfig[:domain]} challenge issued to #{challenged.name}: #{prediction}")
  end
  
  def after_save
    super
    unless @new_challenge
      ChallengeMailer.deliver_update(self)
      challenger.client.update("#{AppConfig[:domain]} challenge update: \"#{event.description}\"")
    end
  end
  
  def friends
    [challenger, challenged]
  end
  
  def complete?
    !result.blank?
  end
  
  def email_addresses
    friends.map(&:email)
  end
  
  def event_description=(desc)
    self.event = Event.create!(:description => desc)
  end
  
  def event_description
    @event_description ||= event.try(:description)  
  end
  
  def challenged_email=(email)
    self.challenged = Friend.find_or_create_by_email(email)
  end
  
  def challenged_email
    @challenged_email ||= challenged.try(:email)
  end
end
