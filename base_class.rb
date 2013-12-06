# TASK: Implement this class to make tests pass
class BaseClass

  def self.method_missing(method_name, argument)
    method_name_parts = method_name.to_s.split('_')
    if method_name_parts.first == 'validates' && method_name_parts.last == 'of'
      validation = method_name_parts[1].to_sym
      @validations[validation] ||= []
      @validations[validation] += [argument]
    end
  end

  def self.inherited(subclass)
    subclass.instance_variable_set(:@validations, {})
  end

  def valid?
    errors.empty? ? true : false
  end

  def errors
    @error_messages = []
    validate
    @error_messages
  end

  private

  def validate
    @validations = self.class.instance_variable_get(:@validations)
    @validations.keys.each do |validation|
      send("validate_#{validation}") if @validations[validation]
    end
  end

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
