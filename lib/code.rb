require 'tsort'
require 'input'
require 'hash'
require 'self_dependency_error'
class Code < Hash
  include TSort

  attr_reader :input
  attr_reader :string

  def initialize(input)
    @input = input
    @string = ''
  end

  def hash
    Input.convert(input).hash
  end

  def jobs
    check_self_dependency
    hash.tsort.join()
  end

  def check_self_dependency
    hash.each do |k, v|
      raise SelfDependencyError if k == v.join
    end
  end
end
