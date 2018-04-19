module Contexts
    module FamilyContexts
    def create_families
      @bmhasna   = FactoryBot.create(:user, username:"bmhasna" , role:"admin" , email: "bmhasnah@hotmail.com" , phone:"9999999999" , password:"12345" , password_confirmation:"12345")
      @yabdelaa = FactoryBot.create(:user, username:"yabdelaa" , role:"admin" , email: "yabdelaal@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      @ndahneem = FactoryBot.create(:user, username:"ndahneem" , role:"admin" , email: "ndahneem@hotmail.com" , phone:"9999999999" ,  password:"12345" , password_confirmation:"12345")
      
      @Elsakka   = FactoryBot.create(:family)
      @Hasnah   = FactoryBot.create(:family, family_name: "Hasnah" , parent_first_name: "Mohammed" , user:  @bmhasna, active:true)
      @Abdelaal = FactoryBot.create(:family, family_name: "Abdelaal" , parent_first_name: "Hassan" , user:  @yabdelaa, active:true)
      @Aldahneem = FactoryBot.create(:family, family_name: "Aldahneem" , parent_first_name: "Ahmed" , user:  @ndahneem, active:false)
    end

    def delete_families
      @Elsakka.delete
      @Hasnah.delete
      @Abdelaal.delete
    end 
      
      
      
      
end 
    end 