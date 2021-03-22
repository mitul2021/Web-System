class Course < Sequel::Model
    
    def get_deg_name()
        return self.deg_name_functional
    end
    
    def get_id()
        return self.deg_id
    end
    
end