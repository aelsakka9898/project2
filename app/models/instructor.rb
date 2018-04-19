class Instructor < ApplicationRecord
  # relationships
  has_many :camp_instructors
  has_many :camps, through: :camp_instructors
  belongs_to :user
  
  # validations
  validates_presence_of :first_name, :last_name


  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :needs_bio, -> { where('bio IS NULL') }
  # scope :needs_bio, -> { where(bio: nil) }  # this also works...
  
  
  #Callbacks
  before_destroy :remove_instructor
  before_update :inactive_user_for_inactive_instructor
 
  
  # class methods
  def self.for_camp(camp)
    # the 'instructive way'... (which I told you if you asked me for help)
    CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
    # the easy way... 
    # camp.instructors
  end

  

  # instance methods
  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end

   
   
   private
  
  def remove_instructor
    q=0 
    self.camps.each do |x|
        q = q+1
    end 
    if q > 0 
      self.active = false
      self.user.active = false
      camp_instructors.each do |x|
        if x.instructor_id == self.id 
          x.instructor = nil 
        end 
      end 
    else
      self.destroy
      self.user.destroy 
    end 
  end


  def inactive_user_for_inactive_instructor
    if self.active == false
      self.user.active = false
    end 
  end 
  
  
  
            
  

  

  


end
