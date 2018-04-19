class Curriculum < ApplicationRecord
  # relationships
  has_many :camps
  

  # validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  ratings_array = [0] + (100..3000).to_a
  validates :min_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validates :max_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validate :max_rating_greater_than_min_rating

  # scopes
  scope :alphabetical, -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_rating, ->(rating) { where("min_rating <= ? and max_rating >= ?", rating, rating) }



  #Callbacks
  before_destroy :raise_rollback!
  before_update :active_validation

  private
  def max_rating_greater_than_min_rating
    # only testing 'greater than' in this method, so...
    return true if self.max_rating.nil? || self.min_rating.nil?
    unless self.max_rating > self.min_rating
      errors.add(:max_rating, "must be greater than the minimum rating")
    end
  end
  
  def raise_rollback!
    raise ActiveRecord::Rollback
  end
  
  
  
  def active_validation
    self.camps.each do |x|
      if self.id == x.curriculum_id
        x.registrations.each do |y|
          if y.camp_id == x.id
            ActiveRecord::Rollback
          end 
        end 
      end 
    end 
    self.active = false
  end 





end
