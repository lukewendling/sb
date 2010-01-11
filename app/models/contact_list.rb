class ContactList
  def initialize(friend)
    @contacts = (friend.bets.map{|c| Contact.new(c.challenged)} + friend.challenges.map{|c| Contact.new(c.challenger)})
  end
  
  def contacts
    @contacts
  end
  
  class Contact
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
