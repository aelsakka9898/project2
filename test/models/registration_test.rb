require 'test_helper'
require 'credit_card_validations/plugins/en_route'
require 'credit_card_validations/plugins/laser'
require 'credit_card_validations/plugins/diners_us'
require "minitest/autorun"

class RegistrationTest < ActiveSupport::TestCase

  def deny(condition)
    assert !condition
  end
  
  # test relationships
  should belong_to (:camp)
  should belong_to (:student)


  context "Within context" do
    setup do 
      create_registrations
    end
    # teardown do
    #   delete_students
      
    # end
    should "show that there are 2 students in alphabetical order" do
      assert_equal ["Abdelaal", "Abdelaal"], Registration.alphabetical.all.map{|c| c.student.last_name}
    end
    
    should "have a for_camp scope" do
     assert_equal [1, 2], Registration.for_camp(@camp1.id).map(&:id).sort
    end
  
  
    should "allow valid cards" do 
      create_valid_cards
      assert @visa13.valid?
      assert @visa16.valid?
    end 
    
    should "not allow invalid cards" do 
      create_invalid_card_lengths
      deny @bad_visa_digits_minus.valid?
      deny @bad_visa_digits_middle.valid?
      
    end
    
    should "allow valid credit card number" do 
      create_valid_cards
      assert_equal "CreditCard number is valid" , @visa13.valid_num
      assert_equal "CreditCard number is valid" , @visa16.valid_num
      assert_equal "CreditCard number is valid" , @mc51.valid_num
      assert_equal "CreditCard number is valid" , @mc54.valid_num
      assert_equal "CreditCard number is valid" , @disc65.valid_num
      assert_equal "CreditCard number is valid" , @disc6011.valid_num
      assert_equal "CreditCard number is valid" , @dccb300.valid_num
      assert_equal "CreditCard number is valid" , @dccb303.valid_num
      assert_equal "CreditCard number is valid" , @amex34.valid_num
      assert_equal "CreditCard number is valid" , @amex37.valid_num
      assert_equal "CreditCard number is valid" , @current_month.valid_num
    end 
    
    
    
    should "not allow invalid card length" do
      create_invalid_card_lengths
      assert_equal "CreditCard number is invalid" , @bad_visa_digits_minus.valid_num
      assert_equal "CreditCard number is invalid" , @bad_visa_digits_middle.valid_num
      assert_equal "CreditCard number is invalid" , @bad_visa_digits_plus.valid_num
      assert_equal "CreditCard number is invalid" , @bad_mc_digits_minus.valid_num
      assert_equal "CreditCard number is invalid" , @bad_mc_digits_plus.valid_num
      assert_equal "CreditCard number is invalid" , @bad_disc_digits_minus.valid_num
      assert_equal "CreditCard number is invalid" , @bad_disc_digits_plus.valid_num
      assert_equal "CreditCard number is invalid" , @bad_dccb_digits_minus.valid_num
      assert_equal "CreditCard number is invalid" , @bad_dccb_digits_plus.valid_num
      assert_equal "CreditCard number is invalid" , @bad_amex_digits_minus.valid_num
      assert_equal "CreditCard number is invalid" , @bad_amex_digits_plus.valid_num
    end
    
    
    should " allow valid dates" do
      create_valid_card_date
      assert_equal "Date is valid" ,  @bad_prefix_visa.valid_date
      assert_equal "Date is valid" , @bad_prefix_mc.valid_date
      assert_equal "Date is valid" , @bad_prefix_disc1.valid_date
      assert_equal "Date is valid" , @bad_prefix_disc2.valid_date
      assert_equal "Date is valid" , @bad_prefix_dccb.valid_date
      assert_equal "Date is valid" , @bad_prefix_amex.valid_date
    end
    
    should "not allow invalid dates" do
      create_invalid_card_dates
      assert_equal "Date is invalid" , @last_year.valid_date
      assert_equal "Date is invalid" ,@last_month.valid_date
      
    end
    
  
    should "allow valid card types" do
      create_valid_cards
      assert_equal("VISA", @visa13.type.name)
      assert_equal("VISA", @visa16.type.name)
      assert_equal("MC", @mc51.type.name)
      assert_equal("MC", @mc54.type.name)
      assert_equal("DISC", @disc65.type.name)
      assert_equal("DISC", @disc6011.type.name)
      assert_equal("DCCB", @dccb300.type.name)
      assert_equal("DCCB", @dccb303.type.name)
      assert_equal("AMEX", @amex34.type.name)
      assert_equal("AMEX", @amex37.type.name)
    end
    
    
    should "allow valid base64 encoded method" do
        @cmu = FactoryBot.create(:location , name:"cmu-qq") 
        @tactics    = FactoryBot.create(:curriculum , name:"tac-tac")
        @camp1 = FactoryBot.create(:camp, curriculum: @tactics, location: @cmu)    
        @yabdelaa = FactoryBot.create(:user, username:"yasmoon" , role:"admin" , email: "yabdelaal@gmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
        @Abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  @yabdelaa, active:true)
        @Yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family_id: 1, date_of_birth: "13/04/1998" , rating: 1)
        @Reg2   = FactoryBot.create(:registration, camp: @camp1 , student: @Yasmin)
       assert true,  @Reg2.pay
    end
  
  
    should "not allow double payment" do
        @cmuqatar = FactoryBot.create(:location , name:"cmu-qatar") 
        @cmu = FactoryBot.create(:location , name:"cmu-qqq") 
        @tactics = FactoryBot.create(:curriculum , name:"tac-tacc")
        @camp1 = FactoryBot.create(:camp, curriculum: @tactics, location: @cmu)  
        @camp2 = FactoryBot.create(:camp, curriculum: @tactics, location: @cmuqatar)  
        @yabdelaa = FactoryBot.create(:user, username:"yasmooon" , role:"admin" , email: "yabdeglaal@gmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
        @Abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  @yabdelaa, active:true)
        @Yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family_id: 1, date_of_birth: "13/04/1998" , rating: 1)
        @Reg8   = FactoryBot.create(:registration, camp: @camp1 , student: @Yasmin)
        @Reg8.payment = nil 
        @Reg8.save 
        @Reg8.pay
        @Reg8.save
        assert true , @Reg8.pay
        @Reg8.pay
        @Reg8.save
        assert_equal false , @Reg8.pay
    end  
    
    
    
      # should "not allow 2 registrations at the same time for the same student" do
      #     cmu = FactoryBot.create(:location , name:"cmu-qqq") 
      #     cmuq = FactoryBot.create(:location , name:"EC-cmu") 
      #     tactics = FactoryBot.create(:curriculum , name:"tac-tacc")
      #     camp1 = FactoryBot.create(:camp, curriculum: tactics, location: cmu , start_date:"19/04/2019" ,end_date:"12/09/2020" ,  time_slot:"pm")    
      #     camp2 = FactoryBot.create(:camp, curriculum: tactics, location: cmuq , start_date:"19/04/2019" , end_date:"12/09/2020" , time_slot:"pm")    
      #     yabdelaa = FactoryBot.create(:user, username:"yasmooon" , role:"admin" , email: "yabdeglaal@gmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      #     abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  yabdelaa, active:true)
      #     yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family_id: 1, date_of_birth: "13/04/1998" , rating: 1)
      #     reg2   = FactoryBot.create(:registration, camp: camp1 , student: yasmin)
      #     reg3   = FactoryBot.create(:registration, camp: camp2 , student: yasmin)
      #     assert_equal true , reg2.save
      #     assert ActiveRecord::Rollback , reg3.save
      #   end  
      
      
    
    
    
    
  
  end
  
  
  
end 
