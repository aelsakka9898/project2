require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:camp_instructors)
  should have_many(:camps).through(:camp_instructors)
  should belong_to(:user)

  # test validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
 
 
    should "inactive instructor if camp exists" do
  
      alexx = FactoryBot.create(:user, username:"alex" , role:"admin" , email: "alexa@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      alex   = FactoryBot.create(:instructor, first_name: "Alex", last_name: "Ferraco", user: alexx,   bio: nil, phone: "412-268-8211")
      
      paule = FactoryBot.create(:user, username:"paule" , role:"admin" , email: "pauleee@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      paul   = FactoryBot.create(:instructor, first_name: "Paul", last_name: "Walker", user: paule,   bio: nil, phone: "412-333-8211")
      
      tactics    = FactoryBot.create(:curriculum)
      cmuq = FactoryBot.create(:location) 
      campnew = FactoryBot.create(:camp, curriculum: tactics, location: cmuq , active:  true)
     
      campnew.start_date = Date.new(2015,7,23)
      campnew.end_date = Date.new(2015,8,23)

      mark_c1 = FactoryBot.create(:camp_instructor, instructor: paul, camp: campnew)
      paul.destroy
      assert_equal false , paule.active
      assert_equal false , paul.active
      
      kate = FactoryBot.create(:user, username:"kate" , role:"admin" , email: "kate@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      wilson = FactoryBot.create(:instructor, first_name: "wilson", last_name: "Ferraco", user: alexx,   bio: nil, phone: "412-268-8211")
      wilson.destroy

    end 
  
    should "inactive user  when instructor is inactive" do     
      samsom = FactoryBot.create(:user, username:"sam" , role:"admin" , email: "sam@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      sam   = FactoryBot.create(:instructor, first_name: "sam", last_name: "dian", user: samsom,   bio: nil, phone: "412-268-8211")
      sam.active = false
      sam.save
      assert_equal false , samsom.active
      
    end 
 
 
 

 
  # set up context
    context "Within context" do
      setup do 
        create_instructors
      end
      
      # teardown do
      #   delete_instructors
      # end
  
      should "show that there are three instructors in alphabetical order" do
        assert_equal ["Alex", "Rachel", "Mark"], Instructor.alphabetical.all.map(&:first_name)
      end
  
      should "show that there are two active instructors" do
        assert_equal 2, Instructor.active.size
        assert_equal ["Alex", "Mark"], Instructor.active.all.map(&:first_name).sort
      end
      
      should "show that there is one inactive instructor" do
        assert_equal 1, Instructor.inactive.size
        assert_equal ["Rachel"], Instructor.inactive.all.map(&:first_name).sort
      end
  
  
  
  
      should "show that name method works" do
        assert_equal "Heimann, Mark", @mark.name
        assert_equal "Ferraco, Alex", @alex.name
      end
      
      should "show that proper_name method works" do
        assert_equal "Mark Heimann", @mark.proper_name
        assert_equal "Alex Ferraco", @alex.proper_name
      end
  
  
  
      should "have a class method to give array of instructors for a given camp" do
        # create additional contexts that are needed
        create_curriculums
        create_active_locations
        create_camps
        create_camp_instructors
        assert_equal ["Alex", "Mark"], Instructor.for_camp(@camp1).map(&:first_name).sort
        assert_equal ["Mark"], Instructor.for_camp(@camp4).map(&:first_name).sort
        # remove those additional contexts
        delete_camp_instructors
        delete_curriculums
        delete_active_locations
        delete_camps
      end
  
    end
  end
