# TASK: Implement this class to make tests pass
class BaseClass

  def self.validates_presence_of(field)
    @validations[:presence] ||= []
    @validations[:presence] += [field]
  end

  def self.validates_numericality_of(field)
    @validations[:numericality] ||= []
    @validations[:numericality] += [field]
  end

  def self.inherited(subclass)
    subclass.instance_variable_set(:@validations, {})
  end

  def valid?
    errors.empty? ? true : false
  end

  def errors
    @error_messages = []
    
    @validations = self.class.instance_variable_get(:@validations)
    validate_presence if @validations[:presence]
    validate_numericality if @validations[:numericality]
    
    @error_messages
  end

  private

  def validate_presence
    @validations[:presence].each do |field|
      @error_messages << "#{field} can't be blank" if send(field).nil? || send(field).strip.length == 0
    end
  end

  def validate_numericality
    @validations[:numericality].each do |field|
      @error_messages << "#{field} must be number" if send(field).nil? || !send(field).is_a?(Numeric)
    end
  end

end
