class Cell
  attr_accessor :contents, :row, :col, :nodes
  def initialize()
    @row = -1
    @col = -1
    @contents = []
    @nodes = []
  end

  def add(rule, node)
    return if @contents.include? rule || rule.blank? || node.blank?
    @contents << rule
    @nodes << node
    @contents.flatten!
    @nodes.flatten!
  end
end
