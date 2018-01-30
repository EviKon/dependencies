class SelfDependencyError < StandardError

  def message
    "There can not be self dependencies"
  end
end
