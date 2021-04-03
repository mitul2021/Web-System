class Userinterest < Sequel::Model

    def validate
        super
        puts "We are in validate method"
        #errors.add(:interest_id, 'cannot be empty') if interest_id.blank?
        errors.add(:interest_id, 'is not an integer') if !(self.interest_id.is_a? Integer)
    end

end