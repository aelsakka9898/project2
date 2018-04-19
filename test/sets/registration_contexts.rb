module Contexts
    module RegistartionContexts
      def create_registrations 
      @north = FactoryBot.create(:location, name: "North Side", street_1: "801 Union Place", street_2: nil, city: "Pittsburgh", zip: "15212")
      @cmu = FactoryBot.create(:location) 
      @tactics    = FactoryBot.create(:curriculum)

      @camp1 = FactoryBot.create(:camp, curriculum: @tactics, location: @cmu , max_students: 1)    
      @camp2 = FactoryBot.create(:camp, curriculum: @tactics, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), location: @cmu , max_students:1)
      @yabdelaa = FactoryBot.create(:user, username:"yabdelaa" , role:"admin" , email: "yabdelaal@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      @ndahneem = FactoryBot.create(:user, username:"ndahneem" , role:"admin" , email: "ndahneem@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      
      @Abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  @yabdelaa, active:true)
      @Aldahneem = FactoryBot.create(:family, family_name: "Aldahneem" , parent_first_name: "Mohammed" , user:  @ndahneem, active:true)
        
      @Yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family_id: 1, date_of_birth: "13/04/1998" , rating: 1)
      @Batoul = FactoryBot.create(:student, first_name: "Batoul", last_name:"Hasnah" , family_id: 2, date_of_birth: "09/11/1997" , rating: 1 , active: true)
      @Noor = FactoryBot.create(:student, first_name: "Noor", last_name:"Aldahneem" , family: @Aldahneem, date_of_birth: "09/11/2012" , rating: 1 , active: false)
      
      @Reg1   = FactoryBot.create(:registration ,  payment: nil)
      @Reg2   = FactoryBot.create(:registration, camp: @camp1 , student: @Yasmin , payment: nil)
      @Reg3 = FactoryBot.create(:registration, camp: @camp2, student: @Noor , payment: nil) 
    end
    
    
    def create_valid_cards
    # Create some valid cards (two for each type)
    @visa13 = CreditCard.new(4123456789012, 2018, 12)
    @visa16 = CreditCard.new(4123456789012345, 2018, 12)
    @mc51 = CreditCard.new(5123456789012345, 2018, 12)
    @mc54 = CreditCard.new(5412345678901234, 2018, 12)
    @disc65 = CreditCard.new(6512345678901234, 2018, 12)
    @disc6011 = CreditCard.new(6011123456789012, 2018, 12)
    @dccb300 = CreditCard.new(30012345678901, 2018, 12)
    @dccb303 = CreditCard.new(30312345678901, 2018, 12)
    @amex34 = CreditCard.new(341234567890123, 2018, 12)
    @amex37 = CreditCard.new(371234567890123, 2018, 12)
    @current_month = CreditCard.new(371234567890123, 2018 , 12)
  end 
  
  
  def create_valid_cards
    # Create some valid cards (two for each type)
    @visa13 = CreditCard.new(4123456789012, 2018, 12)
    @visa16 = CreditCard.new(4123456789012345, 2018, 12)
    @mc51 = CreditCard.new(5123456789012345, 2018, 12)
    @mc54 = CreditCard.new(5412345678901234, 2018, 12)
    @disc65 = CreditCard.new(6512345678901234, 2018, 12)
    @disc6011 = CreditCard.new(6011123456789012, 2018, 12)
    @dccb300 = CreditCard.new(30012345678901, 2018, 12)
    @dccb303 = CreditCard.new(30312345678901, 2018, 12)
    @amex34 = CreditCard.new(341234567890123, 2018, 12)
    @amex37 = CreditCard.new(371234567890123, 2018, 12)
    @current_month = CreditCard.new(371234567890123, 2018 , 12)
  end
  
  
  
  def create_invalid_card_lengths
    # Create some invalid card number lengths (two for each type)
    @bad_visa_digits_minus = CreditCard.new(412345678901, 2018, 12)
    @bad_visa_digits_middle = CreditCard.new(412345678901234, 2018, 12)
    @bad_visa_digits_plus = CreditCard.new(41234567890123456, 2018, 12)
    @bad_mc_digits_minus = CreditCard.new(51234567890123, 2018, 12)
    @bad_mc_digits_plus = CreditCard.new(54123456789012345, 2018, 12)
    @bad_disc_digits_minus = CreditCard.new(651234567890123, 2018, 12)
    @bad_disc_digits_plus = CreditCard.new(60111234567890123, 2018, 12)
    @bad_dccb_digits_minus = CreditCard.new(3001234567890, 2018, 12)
    @bad_dccb_digits_plus = CreditCard.new(303123456789012, 2018, 12)
    @bad_amex_digits_minus = CreditCard.new(34123456789012, 2018, 12)
    @bad_amex_digits_plus = CreditCard.new(3712345678901234, 2018, 01)
  end
  
  def create_valid_card_date
    @bad_prefix_visa = CreditCard.new(1123456789012345, 2018, 12)
    @bad_prefix_mc = CreditCard.new(5623456789012345, 2018, 12)
    @bad_prefix_disc1 = CreditCard.new(6612345678901234, 2018, 12)
    @bad_prefix_disc2 = CreditCard.new(6001123456789012, 2018, 12)
    @bad_prefix_dccb = CreditCard.new(30612345678901, 2018, 12)
    @bad_prefix_amex = CreditCard.new(351234567890123, 2018, 12)
  end
  
  def create_invalid_card_dates
    @last_year = CreditCard.new(4123456789012345, 2015, 12)
    @last_month = CreditCard.new(4123456789012345, 2016, 01)
  end
    
    
    
    

    def delete_registrations 
      @Reg1.delete
      @Reg2.delete
      @Reg3.delete
    end 
      
      
   end 
 end 