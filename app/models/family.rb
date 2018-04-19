class Family < ApplicationRecord
    #Relationships
    has_many :students
    belongs_to :user
    validates_presence_of :family_name
    
    
    #CALLBACKS
    before_destroy :raise_rollback!
    before_update :inactive_remove_upcomming_registrations_inactive_student
    
    #SCOPES
    scope :alphabetical, -> { order('family_name, parent_first_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    
    
    private 
    
    def raise_rollback!
        
        raise ActiveRecord::Rollback
    end
    
    def inactive_remove_upcomming_registrations_inactive_student
        if self.active == false
            self.user.active = false
            self.students.each do |x|
                x.registrations.each do |y|
                    y.destroy
                    y.save 
                end 
            end 
        end 
    end 
  
  
end
