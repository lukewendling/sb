class Challenge < ActiveRecord::Base
  belongs_to :challenger, :class_name => 'Friend'
  belongs_to :challenged, :class_name => 'Friend'
#  synonym for challenged
  belongs_to :recipient, :class_name => 'Friend', :foreign_key => 'challenged_id'
  belongs_to :winner, :class_name => 'Friend'
  belongs_to :event

  has_many :comments, :class_name => 'ChallengeComment', :order => 'created_at desc', :dependent => :delete_all
  has_many :preferences, :class_name => 'ChallengePreference', :dependent => :delete_all
  
  validates_presence_of :challenger, :challenged, :hashed_id, :prediction, :event_description
  
  attr_protected :hashed_id
  
  def self.per_page
    Rails.env == 'development' ? 3 : 10
  end
  
  validates_each :prediction, :event_description, :result do |record, attr, value|
    record.errors.add attr, 'contains invalid content.' if value && value.match( INVALID_CONTENT_PATTERN )
  end
  
  def before_validation
    super
    unless challenger.contacts.map(&:id).uniq.include?(challenged_id)
      errors.add_to_base "Recipient email address not found. You must first <a href='/invitations/new'>invite a friend</a> before sending a challenge.".html_safe!
      return false
    end
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
    challenger.client.update("#{AppConfig[:domain]} challenge for #{challenged.twitter_screen_name}: \"#{prediction}\""[0,140])
  end
  
  def after_save
    super
    unless @new_challenge
      ChallengeMailer.deliver_update(self)
      challenger.client.update("#{AppConfig[:domain]} update: (#{challenged.twitter_screen_name}) \"#{prediction}\""[0,140])
#      challenged.client.update("#{AppConfig[:domain]} challenge update: (#{challenger.twitter_screen_name}) \"#{prediction}\"")
    end
  end
  
  def most_recent_comment
    comments.date_sorted.last
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
