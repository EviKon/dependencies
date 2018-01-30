class Input
  attr_reader :hash
  
  def initialize(input)
    array = input.split(',')
    @hash = get_hash(array)
  end

  def self.convert(input)
    new(input)
  end

  def get_hash(array)
    new_array = []
    array.each do |x|
     new_array.push(x.split('=>'))
    end
    new_array.to_h
  end
end
