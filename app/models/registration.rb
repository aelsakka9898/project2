class Registration < ApplicationRecord
 include ActiveModel::Validations
   #Relationships 
   belongs_to :camp, -> { where(active: true) }
   belongs_to :student, -> { where(active: true) }
# validate :camp_is_not_a_duplicate, on: :create
   
   #callbacks
   before_update :check_double_payment
   attr_accessor :time_slot
   attr_accessor :start_date
   
   
   #SCOPES
   scope :alphabetical, -> { joins(:student).order('last_name'  , 'first_name') }
   scope :for_camp, ->(camp_id) { where("camp_id = ?", camp_id) } 

   require "base64"
    
   
    def check_double_payment
        if self.payment == nil
          self.pay
          
        else
           "Payement is invalid" 
        end 
    end
    
    
    
    def pay
        if self.payment == nil
            "Payement is valid and created" 
            self.payment = Base64.encode64("Camp: #{self.camp.name} ; Student: #{self.student.name} ; Amount_paid: #{self.camp.cost} ; Card: #{:type}"  )
        else
            false
        end 
    end 
    

#     def already_exists?
#         Registration.where(camp_id: self.camp_id , start_date: self.camp.start_date , time_slot: self.camp.time_slot).size == 1
#     end
    
#     def camp_is_not_a_duplicate
#         return true if  self.camp_id.nil?  || self.camp.start_date.nil? || self.camp.time_slot.nil?
#         if self.already_exists?
#           raise ActiveRecord::Rollback
#         end
#     end
  
 end  

  

class CreditCardType
		attr_reader :name, :pattern
		
		def initialize(name, pattern)
			@name, @pattern = name, pattern
		end
		
		def match(number)
			number.to_s.match(@pattern)
		end
	end
	
	

class CreditCard
    VALID_TYPES = [
			CreditCardType.new("AMEX", /^3(4|7)\d{13}$/),
			CreditCardType.new("DCCB", /^30[0-5]\d{11}$/),
			CreditCardType.new("DISC", /^6(011|5\d\d)\d{12}$/),
			CreditCardType.new("MC", /^5[1-5]\d{14}$/),
			CreditCardType.new("VISA", /^4\d{12}(\d{3})?$/)
		]
		
    


  
        def initialize(number , year , month )
            @number = number 
            @year = year 
            @month = month 
            @type = type 
            @type = VALID_TYPES.detect { |type| type.match(@number) }
        end
   
        attr_accessor :number
        attr_accessor :year
        attr_accessor :month
        attr_accessor :type
  
        def date?
            if (Time.new.year  <= @year) && (Time.new.month <= @month)
              true 
            else 
              false
            end 
            
        end  
 
        def credit?
            if @number.to_s =~ /^3[47][0-9]{13}$/
              true 
            elsif @number.to_s =~ /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/
              true 
            elsif @number.to_s =~ /^6(?:011|5[0-9]{2})[0-9]{12}$/
              true 
            elsif @number.to_s =~ /^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$/
              true 
            elsif @number.to_s =~ /^4[0-9]{12}(?:[0-9]{3})?$/
              true
            else
              false
            end 
         end 

  
        def valid?
            if date? && credit?
                true 
            else
               false
            end 
        end 
  
  
        def valid_date
            if date?
                "Date is valid"
            else
                "Date is invalid"
               
            end 
        end 
  
  
        def valid_num
            if credit?
               "CreditCard number is valid"
            else
                "CreditCard number is invalid"
            end 
         
        end 
end 


