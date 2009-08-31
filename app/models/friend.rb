class Friend < ActiveRecord::Base
  has_many :challenges, :foreign_key => 'challenged_id', :order => 'created_at desc'
  has_many :bets, :foreign_key => 'challenger_id', :class_name => 'Challenge', :order => 'created_at desc'
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation
    
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :name, :email, :password, :password_confirmation
  attr_accessible :atoken, :asecret
  attr_accessible :invitation_token
  
  attr_accessor :password
  before_save :prepare_password
  after_save :fetch_twitter_details
  before_create :set_invitation_limit
  after_create :notify_inviter
  
  validates_presence_of :email, :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6, :allow_blank => true

  validates_presence_of :invitation_id, :message => 'is required', :on => :create
  validates_uniqueness_of :invitation_id, :on => :create


  def name
    self[:name] || username
  end

  def email
    self[:email].downcase
  end
    
  # login can be either username or email address
  def self.authenticate(login, pass)
    friend = find_by_username(login) || find_by_email(login)
    return friend if friend && friend.matching_password?(pass)
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end
  
  def can_tweet?
    !atoken.blank? && !asecret.blank?
  end
  
  def twitter_id
    atoken.split('-').first if can_tweet?
  end
  
  def twitter_user
    unless twitter_id.nil?
      @twitter_user ||= Twitter.user(twitter_id)
    end
  end
  
  def oauth
    @oauth ||= Twitter::OAuth.new(ConsumerConfig['token'], ConsumerConfig['secret'])
  end
  
  def client
    @client ||= begin
      oauth.authorize_from_access(atoken, asecret)
      Twitter::Base.new(oauth)
    end
  end
    
  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end
  
  private
  
    def prepare_password
      unless password.blank?
        self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
        self.password_hash = encrypt_password(password)
      end
    end
    
    def fetch_twitter_details
      unless twitter_user.nil?
        self.twitter_screen_name = twitter_user.screen_name
        self.twitter_profile_image_url = twitter_user.profile_image_url
      end
    end
    
    def notify_inviter
      unless invitation.nil?
        InvitationMailer.deliver_invite_complete(invitation)
      end
    end
    
    def encrypt_password(pass)
      Digest::SHA1.hexdigest([pass, password_salt].join)
    end
    
    def set_invitation_limit
      self.invitation_limit = 10
    end

end
