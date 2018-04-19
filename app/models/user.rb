class User < ApplicationRecord
    has_one :family
    has_one :instructor
    has_secure_password
   # VALID_NAMES = %w(admin parent instructor)

    validates :username, presence: true, uniqueness: { case_sensitive: false}
    #validates_inclusion_of :role, in:  VALID_NAMES, message: "is not an accepted role"
    validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
    validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
    # ROLES =['admin' , 'instructor' , 'parent']
    # validates :role, inclusion: { in: ROLES.map{|a| a}, message: "is not valid state", allow_blank: true }

    validates :password_confirmation, :presence => true, :if => '!password.nil?'
    validates :password, :presence => { :on => :create }, :length   => { :minimum => 4}, :confirmation => true


end
