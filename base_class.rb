# TASK: Implement this class to make tests pass
class BaseClass

  def self.method_missing(method_name, *arguments, &block)
    if validation_method?(method_name)
      validation = method_name.to_s.split('_')[1].to_sym
      @validations[validation] ||= []
      @validations[validation] += [arguments.first]
    else
      super
    end
  end

  def self.respond_to_missing?(method_name, include_private = false)
    validation_method?(method_name) || super
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

  def self.validation_method?(method_name)
    method_name_parts = method_name.to_s.split('_')
    method_name_parts[0] == 'validates' && method_name_parts[2] == 'of'
  end

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
