require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_one (:family) 
  should have_one (:instructor) 
  
  #VALIDATE PRESENCE AND UNIQENESS
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username).case_insensitive
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email).case_insensitive
  
  
  #VALIDATE ROLE {ADMIN INSTRUCTOR PARENT}
  should allow_value("admin").for(:role)
  should allow_value("parent").for(:role)
  should allow_value("instructor").for(:role)
  # should_not allow_value("bad").for(:role)
  # should_not allow_value("1:00").for(:role)  
  # should_not allow_value(900).for(:role)
  
  
  #VALIDATE EMAIL 
  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  
  # VALIDATE PHONE
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  
  
  #VALIDATE PASSWORD LENGTH 
  should allow_value("1234").for(:password)
  should allow_value("1234567").for(:password)
  should_not allow_value("123").for(:password)
  
  #PASSWORD VALIDATION
  should have_secure_password
  

 

end
