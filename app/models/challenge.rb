class Challenge < ActiveRecord::Base
  belongs_to :challenger, :class_name => 'Friend'
  belongs_to :challenged, :class_name => 'Friend'
#  synonym for challenged
  belongs_to :recipient, :class_name => 'Friend', :foreign_key => 'challenged_id'
  belongs_to :winner, :class_name => 'Friend'
  belongs_to :event

  has_many :comments, :class_name => 'ChallengeComment', :order => 'created_at desc', :dependent => :delete_all
  has_many :preferences, :class_name => 'ChallengePreference', :dependent => :delete_all
  
  validates_presence_of :challenger, :hashed_id, :prediction
  validates_presence_of :recipient, :message => 'email address not found. You must first invite a friend before sending them a challenge.'
  
  attr_protected :hashed_id
  
  def self.per_page
    Rails.env == 'development' ? 3 : 10
  end
  
  def before_validation_on_create
    super
    self.hashed_id = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
  
  def after_create
    super
#    create default prefs
    friends.each{ |f| preferences.create(:friend => f) }
    @new_challenge = true # flag to halt update notification
    ChallengeMailer.deliver_the_challenge(self)
    challenger.client.update("#{AppConfig[:domain]} challenge issued to #{challenged.twitter_screen_name}: \"#{prediction}\"")
  end
  
  def after_save
    super
    unless @new_challenge
      ChallengeMailer.deliver_update(self)
      challenger.client.update("#{AppConfig[:domain]} challenge update: (#{challenged.twitter_screen_name}) \"#{prediction}\"")
#      challenged.client.update("#{AppConfig[:domain]} challenge update: (#{challenger.twitter_screen_name}) \"#{prediction}\"")
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
    unless event.nil?
      @event_description ||= event.description
    end  
  end
  
  def challenged_email=(email)
    self.challenged = Friend.find_by_email(email)
  end
  
  def challenged_email
    unless challenged.nil?
      @challenged_email ||= challenged.email
    end
  end
end
