require 'circular_dependency_error'

class Job
  attr_reader :string
  attr_reader :job
  attr_reader :hash
  attr_reader :input

  def initialize(k, v, string, input)
    @string = string
    @first = k
    @input = input
    @job = checking_the_hash(k, v)
  end

  def hash
    hash ||= Input.convert(input).hash
  end

  def checking_the_hash(k, v)
    if job_has_dependancy(k, v)
      check_dependency(k ,v)
    elsif job_has_no_dependancy(k ,v)
      k
    else
      ''
    end
  end

  def job_has_dependancy(k, v)
    v != ' ' && !string.include?(k)
  end

  def job_has_no_dependancy(k, v)
    !string.include?(k) && v == ' '
  end

  def check_dependency(k, v)
    if check_value(v)
      check_circularity(v)

      checking_the_hash(v,get_new_value(v)) + k
    else
      v + k
    end
  end

  def check_value(v)
    hash.each_key do |key|
      return true if key == v
    end
    false
  end

  def check_circularity(v)
    raise CircularDependancyError if get_new_value(v) == @first
  end

  def get_new_value(v)
    hash.each do |key,value|
      return value if key == v
    end
  end
end
