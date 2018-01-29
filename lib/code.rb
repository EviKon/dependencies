class Code
  attr_reader :input

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

  def iterate_the_hash
    hash = convert_to_hash
    string = ''
    hash.each_key do |x|
      string.concat(x)
    end
    string
  end

  def iterate_the_hash_with_keys_and_values
    hash = convert_to_hash
    string = ''
    hash.each do |k,v|
      p k
      p v
      string.concat(checking_the_hash(k,v,string))
      p string
    end
    string
  end

  def check_value(v)
    hash = convert_to_hash

    hash.each_key do |key|
      if key == v
        return true
      end
    end
    false
  end

  def checking_the_hash(key,v,string)
    if v != ' ' && !string.include?(key)
      if check_value(v)
        new_value = get_key(v)
        checking_the_hash(v,new_value,string)+key
      else
        v+key
      end
    elsif !string.include?(key) && v == ' '
      key
    else
      ''
    end
  end

  def get_key(v)
    hash = convert_to_hash
    hash.each do |key,value|
      if key == v
        return value
      end
    end
  end
end
