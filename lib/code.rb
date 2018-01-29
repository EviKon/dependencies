class Code
  attr_reader :input
  attr_reader :first
  attr_reader :hash
  attr_reader :string

  def initialize(input)
    @input = input
  end

  def convert_to_hash
    array = input.split(',')
    new_array = []
    array.each do |x|
     new_array.push(x.split('=>'))
    end
    new_array.to_h
  end

  def jobs
    @hash = convert_to_hash
    @string = ''
    hash.each do |k,v|
      raise error if k == v

      @first = k
      string.concat(checking_the_hash(k,v))
    end
    string
  end

  def checking_the_hash(key,v)
    if job_has_dependancy(key,v)
      dependency(key,v)
    elsif job_has_no_dependancy(key,v)
      key
    else
      ''
    end
  end

  def job_has_dependancy(key,v)
    v != ' ' && !string.include?(key)
  end

  def job_has_no_dependancy(key,v)
    !string.include?(key) && v == ' '
  end

  def dependency(key,v)
    if check_value(v)
      check_circularity(v)

      checking_the_hash(v,get_new_value(v)) + key
    else
      v + key
    end
  end

  def check_value(v)
    hash.each_key do |key|
      return true if key == v
    end
    false
  end

  def check_circularity(v)
    raise circular_error if get_new_value(v) == first
  end

  def get_new_value(v)
    hash.each do |key,value|
      return value if key == v
    end
  end

  def error
    "There can not be self dependencies"
  end

  def circular_error
    "There can not be circular dependencies"
  end
end
