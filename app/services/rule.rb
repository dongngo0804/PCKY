class Rule
  def initialize(rule)
    words = rule.split("->")
    self.@left = words[0].trim()
    self.@right = words[1].trim()
  end

end