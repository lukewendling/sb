class ContactList
  def initialize(friend)
    @contacts = (friend.bets.map{|c| Contact.new(c.challenged).friend} + friend.challenges.map{|c| Contact.new(c.challenger).friend}).uniq
  end
  
  def contacts
    @contacts
  end
  
  class Contact
    attr_reader :friend
    
    def initialize(friend)
      @friend = friend
    end
    
    def name
      @friend.name
    end
    
    def id
      @friend.id
    end
    
    def email
      @friend.email
    end
  end
end
