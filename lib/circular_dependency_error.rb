class CircularDependancyError < StandardError

  def message
    "There can not be circular dependencies"
  end
end
