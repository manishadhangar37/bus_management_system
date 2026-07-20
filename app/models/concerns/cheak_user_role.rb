module CheakUserRole 
   extend ActiveSupport::Concern
    def self.check_role
        cookies[:user_id]
        role = user.role
        
    
    end
end
