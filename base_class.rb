# TASK: Implement this class to make tests pass
class BaseClass

  def self.validates_presence_of(field)
  end

  def self.validates_numericality_of(field)
  end

  def valid?
    errors.empty? ? true : false
  end

  def errors
    error_messages = []
    error_messages << "name can't be blank" if name.nil? || name.strip.length == 0
    error_messages << "price must be number" if !price.is_a?(Numeric)
    error_messages
  end

end
