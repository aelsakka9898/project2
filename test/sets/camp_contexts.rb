module Contexts
  module CampContexts
    def create_camps
      # assumes create_curriculums prior
      @camp1 = FactoryBot.create(:camp, curriculum: @tactics, location: @cmu , max_students: 1)    
      @camp2 = FactoryBot.create(:camp, curriculum: @tactics, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), location: @cmu)
      @camp3 = FactoryBot.create(:camp, curriculum: @tactics, time_slot: "pm", active: false, location: @cmu)
      @camp4 = FactoryBot.create(:camp, curriculum: @endgames, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), time_slot: "pm", location: @cmu)
 
      @yasminiii = FactoryBot.create(:user, username:"yasminiii" , role:"admin" , email: "yabdelaal@yahoo.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      @noori = FactoryBot.create(:user, username:"noori" , role:"admin" , email: "ndahneem@yahoo.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      @Abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  @yasminiii, active:true)
      @Aldahneem = FactoryBot.create(:family, family_name: "Aldahneem" , parent_first_name: "Mohammed" , user:  @noori, active:true)
      @Yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family_id: 1, date_of_birth: "13/04/1998" , rating: 1)
      @Noor = FactoryBot.create(:student, first_name: "Noor", last_name:"Aldahneem" , family: @Aldahneem, date_of_birth: "09/11/2012" , rating: 1 , active: false)
      @Reg2   = FactoryBot.create(:registration, camp: @camp1 , student: @Yasmin , payment: nil)
      @Reg3 = FactoryBot.create(:registration, camp: @camp1, student: @Noor , payment: nil) 
    
    end

    def delete_camps
      @camp1.delete
      @camp2.delete
      @camp3.delete
      @camp4.delete
      delete_curriculums
      
    end

    def create_past_camps
      # assumes create_more_curriculums prior
      @camp10 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,6,3), end_date: Date.new(2018,6,7), time_slot: "am", location: @cmu)
      @camp11 = FactoryBot.create(:camp, curriculum: @nimzo, start_date: Date.new(2018,6,3), end_date: Date.new(2018,6,7), time_slot: "pm", location: @north)
      @camp12 = FactoryBot.create(:camp, curriculum: @positional, start_date: Date.new(2018,6,10), end_date: Date.new(2018,6,14), time_slot: "am", location: @north)
      @camp13 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,6,10), end_date: Date.new(2018,6,14), time_slot: "pm", location: @north)
      @camp10.update_attributes(:start_date => Date.new(2017,7,3), :end_date => Date.new(2017,7,7))
      @camp11.update_attributes(:start_date => Date.new(2017,7,3), :end_date => Date.new(2017,7,7))
      @camp12.update_attributes(:start_date => Date.new(2017,7,10), :end_date => Date.new(2017,7,14))
      @camp13.update_attributes(:start_date => Date.new(2017,7,10), :end_date => Date.new(2017,7,14))

      # @camp10.start_date = Date.new(2017,7,3)
      # @camp10.end_date = Date.new(2017,7,7)
      # @camp10.save
      # @camp11.start_date = Date.new(2017,7,3)
      # @camp11.end_date = Date.new(2017,7,7)
      # @camp11.save
      # @camp12.start_date = Date.new(2017,7,10)
      # @camp12.end_date = Date.new(2017,7,14)
      # @camp12.save
      # @camp13.start_date = Date.new(2017,7,10)
      # @camp13.end_date = Date.new(2017,7,14)
      # @camp13.save
    end

    def delete_past_camps
      @camp10.delete
      @camp11.delete
      @camp12.delete
      @camp13.delete
    end

    def create_upcoming_camps
      # assumes create_more_curriculums prior
      @camp20 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,6,11), end_date: Date.new(2018,6,15), time_slot: "am", location: @north)
      @camp21 = FactoryBot.create(:camp, curriculum: @nimzo, start_date: Date.new(2018,6,11), end_date: Date.new(2018,6,15), time_slot: "pm", location: @cmu)
      @camp22 = FactoryBot.create(:camp, curriculum: @positional, start_date: Date.new(2018,6,18), end_date: Date.new(2018,6,22), time_slot: "am", location: @cmu)
      @camp23 = FactoryBot.create(:camp, curriculum: @openings, start_date: Date.new(2018,6,18), end_date: Date.new(2018,6,22), time_slot: "pm", location: @cmu)
      @camp24 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,6,25), end_date: Date.new(2018,6,29), time_slot: "am", location: @cmu)
      @camp25 = FactoryBot.create(:camp, curriculum: @adv_tactics, start_date: Date.new(2018,6,25), end_date: Date.new(2018,6,29), time_slot: "pm", location: @cmu)
      @camp26 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,7,9), end_date: Date.new(2018,7,13), time_slot: "am", location: @cmu)
      @camp27 = FactoryBot.create(:camp, curriculum: @nimzo, start_date: Date.new(2018,7,9), end_date: Date.new(2018,7,13), time_slot: "pm", location: @cmu)
    end

    def delete_upcoming_camps
      @camp20.delete
      @camp21.delete
      @camp22.delete
      @camp23.delete
      @camp24.delete
      @camp25.delete
      @camp26.delete
      @camp27.delete
    end
  end
end