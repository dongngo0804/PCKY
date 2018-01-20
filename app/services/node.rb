class Node
  attr_accessor :left, :right, :type, :word, :freq
  def initialize(left, right, type, word, freq)
    @left = left
    @right = right
    @type = type
    @word = word
    @freq = freq
  end
end
