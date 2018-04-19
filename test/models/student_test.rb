require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #Validations
  should have_many(:registrations)
  should belong_to(:family)
  should have_many(:camps).through(:registrations)
  
    should "set rating to 0 if nil" do
      yabdelaa = FactoryBot.create(:user, username:"yabdelaa" , role:"admin" , email: "yabdelaal@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  yabdelaa, active:true)
      yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family_id: 1, date_of_birth: "13/04/1998" , rating:nil)
      maryam = FactoryBot.create(:student, first_name: "Maryam", last_name:"Abdelaal" , family_id: 1, date_of_birth: "13/04/1398" , rating:900)
      assert_equal 0 , yasmin.rating
      
      #To validate that rating is between 0-3000
      maryam.rating = 300000 
      assert_equal false , maryam.save
    end
  
  
    should "not delete student if associated to registartion but make student inactive" do
      cmu = FactoryBot.create(:location) 
      tactics = FactoryBot.create(:curriculum)
      camp1 = FactoryBot.create(:camp, curriculum: tactics, location: cmu)  
      yabdelaa = FactoryBot.create(:user, username:"yabdelaa" , role:"admin" , email: "yabdelaal@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  yabdelaa, active:true)
      yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family: abdelaal, date_of_birth: "13/04/1998" , rating: 1 , active: true )
      reg2  = FactoryBot.create(:registration, camp: camp1 , student: yasmin)
      assert   ActiveRecord::Rollback , yasmin.destroy  
      assert_equal false , yasmin.active
    end 
  
  
   should "remove upcomming registartions if student is inactive" do
      cmu = FactoryBot.create(:location) 
      tactics = FactoryBot.create(:curriculum)
      camp1 = FactoryBot.create(:camp, curriculum: tactics, location: cmu)  
      yabdelaa = FactoryBot.create(:user, username:"yabdelaa" , role:"parent" , email: "yabdelaal@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  yabdelaa, active:true)
      yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family: abdelaal, date_of_birth: "13/04/1998" , rating: 1 , active: true )
      reg2 = FactoryBot.create(:registration, camp: camp1 , student: yasmin)
      reg2.pay 
      reg2.save
      yasmin.active = false
      yasmin.save 
      assert_equal 0 , yasmin.registrations.count
    end 
  
  
  
  context "Within context" do
    setup do 
      create_students
      
    end
    
    teardown do
      delete_students
    end
  
    should "show that there are three students in alphabetical order" do
      assert_equal ["Abdelaal", "Aldahneem", "Elsakka", "Hasnah"], Student.alphabetical.all.map(&:last_name )
    end
  
    should "show that there are 3 active student" do
      assert_equal 3, Student.active.size
       assert_equal ["Aya", "Batoul" , "Yasmin"], Student.active.all.map(&:first_name).sort
    end 
    
    should "show that there is one inactive studeny" do
      assert_equal 1, Student.inactive.size
      assert_equal ["Noor"], Student.inactive.all.map(&:first_name).sort
    end
    
     should "have a below_rating scope" do
      assert_equal ["Aya", "Batoul", "Noor", "Yasmin"], Student.below_rating(5).all.map(&:first_name).sort
    end
    
    should "have a at_or_above_rating scope" do
      assert_equal ["Aya", "Batoul", "Noor", "Yasmin"], Student.at_or_above_rating(1).all.map(&:first_name).sort
    end
    
    
     should "show that name method works" do
      assert_equal "Hasnah, Batoul", @Batoul.name
      assert_equal "Abdelaal, Yasmin", @Yasmin.name
    end
    
    should "show that proper_name method works" do
      assert_equal "Batoul Hasnah", @Batoul.proper_name
      assert_equal "Yasmin Abdelaal", @Yasmin.proper_name
    end
    
    should "show that age method works" do
      assert_equal 20 , @Yasmin.age
     
    end
    
    

    
    
end
end 
