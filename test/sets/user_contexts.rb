module Contexts
    module UserContexts
      def create_users
      @Mike   = FactoryBot.create(:user)
      @bmhasna   = FactoryBot.create(:user, username:"bmhasna" , role:"admin" , email:"bmhasnah@cmu.edu" , phone:"999-9999-999" , password:"12345")
      @yabdelaa = FactoryBot.create(:user, username:"yabdelaa" , role:"admin" , email:"yabdelaal@cmu.edu" , phone:"999-9922-999" ,password:"12345" )
    end

    def delete_users
      @Mike.delete
      @bmhasna.delete
      @yabdelaa.delete
    end 
      
      
      
      
end 
    end 