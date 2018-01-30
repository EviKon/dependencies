require 'input'
require 'job'
require 'self_dependency_error'
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
      raise SelfDependencyError if k == v
      string.concat(Job.new(k, v, string, input).job)
    end
    string
  end
end
