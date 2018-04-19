module Contexts
  module StudentContexts
    def create_students
      @Mike   = FactoryBot.create(:user)
      @bmhasna   = FactoryBot.create(:user, username:"bmhasna" , role:"admin" , email: "bmhasnah@hotmail.com" , phone:"9999999999" , password:"12345" , password_confirmation:"12345")
      @yabdelaa = FactoryBot.create(:user, username:"yabdelaa" , role:"admin" , email: "yabdelaal@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      @ndahneem = FactoryBot.create(:user, username:"ndahneem" , role:"admin" , email: "ndahneem@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      
      @Hasnah   = FactoryBot.create(:family, family_name: "Hasnah" , parent_first_name: "Mohammed" , user:  @bmhasna, active:true)
      @Abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  @yabdelaa, active:true)
      @Aldahneem = FactoryBot.create(:family, family_name: "Aldahneem" , parent_first_name: "Mohammed" , user:  @ndahneem, active:true)
      
      @aya  = FactoryBot.create(:student)
      @Yasmin = FactoryBot.create(:student, first_name: "Yasmin", last_name:"Abdelaal" , family_id: 1, date_of_birth: "13/04/1998")
      @Batoul = FactoryBot.create(:student, first_name: "Batoul", last_name:"Hasnah" , family_id: 2, date_of_birth: "09/11/1997" , rating: 1 , active: true)
      @Noor = FactoryBot.create(:student, first_name: "Noor", last_name:"Aldahneem" , family: @Aldahneem, date_of_birth: "09/11/2012" , rating: 1 , active: false)
    end

    def delete_students
      @aya.delete
      @Yasmin.delete
      @Batoul.delete
    end
    
    
end 
end 