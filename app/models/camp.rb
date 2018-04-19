class Camp < ApplicationRecord
  # relationships
  belongs_to :curriculum
  belongs_to :location
  has_many :camp_instructors
  has_many :instructors, through: :camp_instructors
  has_many :registrations
  has_many :students , through: :registrations
  
  #callbacks
  before_update :inactive_camps
  before_update :remove_instructors_from_inactive_camp
  before_destroy :destroy_camp
  
  

  # validations
  validates_presence_of :location_id, :curriculum_id, :time_slot, :start_date
  validates_numericality_of :cost, greater_than_or_equal_to: 0
  validates_date :start_date, :on_or_after => lambda { Date.today }, :on_or_after_message => "cannot be in the past", on:  :create
  validates_date :end_date, :on_or_after => :start_date
  validates_inclusion_of :time_slot, in: %w[am pm], message: "is not an accepted time slot"
  validates_numericality_of :max_students, only_integer: true, greater_than: 0, allow_blank: true
  validate :curriculum_is_active_in_the_system
  validate :location_is_active_in_the_system
  validate :camp_is_not_a_duplicate, on: :create
  validate :max_students_not_greater_than_capacity

  # scopes
  scope :alphabetical, -> { joins(:curriculum).order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :chronological, -> { order('start_date','end_date') }
  scope :morning, -> { where('time_slot = ?','am') }
  scope :afternoon, -> { where('time_slot = ?','pm') }
  scope :upcoming, -> { where('start_date >= ?', Date.today) }
  scope :past, -> { where('end_date < ?', Date.today) }
  scope :for_curriculum, ->(curriculum_id) { where("curriculum_id = ?", curriculum_id) }

  scope :full, -> { joins(:registrations).where("max_students = ?",  Registration.find_by(camp_id: self.ids)) }
  scope :empty, -> { joins(:registrations).where("true =?" , Registration.find_by(camp_id: self.ids)).nil? }
  
  # instance methods
  def name
    self.curriculum.name
  end

  def already_exists?
    Camp.where(time_slot: self.time_slot, start_date: self.start_date, location_id: self.location_id).size == 1
  end
  
  
  def is_full? 
    q = 0 
    if self.registrations.count > 0 
      self.registrations.each do |x|
        q = q+1
      end 
      if q == self.max_students
        true 
      else
        false
      end
    else
      false
    end 
  end 
  
  
  
  
  def enrollment 
    q = 0 
    if self.registrations.count > 0 
      self.registrations.each do |x|
        q = q+1
      end 
        q 
      else
        0
    end 
  end 



  
  


  # private
  def curriculum_is_active_in_the_system
    return if self.curriculum.nil?
    errors.add(:curriculum, "is not currently active") unless self.curriculum.active
  end

  def location_is_active_in_the_system
    return if self.location.nil?
    errors.add(:location, "is not currently active") unless self.location.active
  end

  def camp_is_not_a_duplicate
    return true if self.time_slot.nil? || self.start_date.nil? || self.location_id.nil?
    if self.already_exists?
      errors.add(:time_slot, "already exists for start date, time slot and location")
    end
  end
  
  

  

  def max_students_not_greater_than_capacity
    return true if self.max_students.nil? || self.location_id.nil?
    if self.max_students > self.location.max_capacity
      errors.add(:max_students, "is greater than the location capacity")
    end
  end

  def remove_instructors_from_inactive_camp
    # confirm that camp is marked as inactive
    if !self.active
      self.camp_instructors.each{|ci| ci.destroy}
    end
  end
  
  
  def inactive_camps
    num=0 
    registrations.each do |x|
      if x.camp_id == self.id 
        num = num+1
        self.active = true 
        raise ActiveRecord::Rollback
      end 
    end
    if num == 0 
      self.active = false 
    end 
    
  end
  
  
  def destroy_camp
    q=0
    self.registrations.each do |x|
      if x.camp_id == self.id 
        q = q+1 
      end 
    end 
    if q > 0 
      raise ActiveRecord::Rollback
    else
      self.destroy
      self.camp_instructors.each do |y|
        if y.camp_id == self.id 
           y.camp_id = nil 
        end 
      end 
    end 
  end 


  


end 