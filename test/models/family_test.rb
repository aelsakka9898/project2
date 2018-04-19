require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # Test relationships
  should have_many(:students)
  should belong_to(:user)
  
  #Test validations
  
  should allow_value("Elsakka").for(:family_name)
  should allow_value("Ali").for(:parent_first_name)
  should allow_value(1).for(:user_id)
  should allow_value(true).for(:active)

  ##CALL BACK TEST

    should "not delete family" do
      yabdelaa = FactoryBot.create(:user, username:"yabdelaa" , role:"admin" , email: "yabdelaal@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  yabdelaa, active:true)
      assert  ActiveRecord::Rollback, abdelaal.destroy  
    end 
    
    should "inactive students if family inactive" do
      yabdelaa = FactoryBot.create(:user, username:"yabdelaa" , role:"admin" , email: "yabdelaal@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  yabdelaa, active:true)
      tactics    = FactoryBot.create(:curriculum)
      cmu = FactoryBot.create(:location) 
      camp1 = FactoryBot.create(:camp, curriculum: tactics, location: cmu)   
      yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family: abdelaal, date_of_birth: "13/04/1998" , rating: 1 , active:true)
      reg2 = FactoryBot.create(:registration, camp: camp1 , student: yasmin )
      reg2.pay 
      reg2.save
      abdelaal.active = false
      abdelaal.save 
      assert_equal 0 , yasmin.registrations.count
      assert_equal false , yabdelaa.active
    end 
  
  
  
  context "Within context" do
    setup do 
      create_families
    end
    # teardown do
    #   delete_students
      
    # end
    should "show that there are four families in alphabetical order" do
        assert_equal ["Abdelaal", "Aldahneem", "Elsakka","Hasnah"], Family.alphabetical.all.map(&:family_name )
    end
    
    should "show that there are 3 active families" do
        assert_equal 3, Family.active.size
        assert_equal ["Abdelaal", "Elsakka", "Hasnah"], Family.active.all.map(&:family_name).sort
    end 
    
    
    should "show that there are 1 inactive families" do
        assert_equal 1, Family.inactive.size
        assert_equal ["Aldahneem"], Family.inactive.all.map(&:family_name).sort
    end 
    
    
  end 
    
end
