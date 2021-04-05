class Userinterest < Sequel::Model

    def validate
        super
        errors.add(:interest_id, 'is not an integer') if !(self.interest_id.is_a? Integer)
    end

end