class Student < ApplicationRecord
    has_many :registrations
    belongs_to :family
    has_many :camps , through: :registrations  #check this one
    validate :rating_between_0_3000
    
    
    scope :alphabetical, -> { order('last_name, first_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :below_rating, ->(ceiling) { where("rating <= ? ", ceiling)}
    scope :at_or_above_rating, ->(floor) { where("rating >= ?", floor) }
    
    
   # callbacks
    before_save :set_rating_to_zero_if_nil
    before_destroy :raise_rollback!
    before_update :inactive_remove_upcomming_registrations
    
  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end
  
  def age
    a = Date.today.year - date_of_birth.year
    return a
  end  

  private
  def rating_between_0_3000
    # only testing 'greater than' in this method, so...
    return true if self.rating.nil? || self.rating.nil?
    unless self.rating > 0 && self.rating < 3000
      errors.add(:rating, "must be between 0 and 3000")
    end
  end
  
  def set_rating_to_zero_if_nil
    if self.rating.nil?
      self.rating = 0 
    end 
  end 
  
  
  def raise_rollback!
    self.registrations.each do |x|
      if x.student.id == self.id
        self.active = false 
        raise ActiveRecord::Rollback
      end 
      end 
  end
  
  
  def inactive_remove_upcomming_registrations
      self.registrations.each do |x|
        if self.active == false 
        x.destroy 
        x.save 
      end 
    end 
  end 
  

end
