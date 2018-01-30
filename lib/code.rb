require 'input'
require 'job'
class Code
  attr_reader :input
  attr_reader :string

  def initialize(input)
    @input = input
    @string = ''
  end

  def hash
    hash ||= Input.convert(input).hash
  end

  def jobs
    hash.each do |k,v|
      raise error if k == v
      string.concat(Job.new(k, v, string, input).job)
    end
    string
  end

  def error
    "There can not be self dependencies"
  end
end
