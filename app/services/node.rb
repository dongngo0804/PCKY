class Node
  attr_accessor :left, :right, :type, :word
  def initialize(left, right, type, word)
    @left = left
    @right = right
    @type = type
    @word = word
  end
end
