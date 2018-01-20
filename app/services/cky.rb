class Cky
  attr_accessor :words, :table, :nodes

  def initialize(sentence)
    @words = sentence.strip.split(' ')
    @table = Array.new(@words.length){ Array.new(@words.length + 1){ Cell.new } }
    add_words_to_table
  end

  def add_words_to_table
    for i in 1..@words.length do
      c = Cell.new
      rules = Rule.where(right: @words[i-1])
      rules.each do |rule|
        c.add(rule, Node.new(nil, nil, rule.left, @words[i-1], rule.freq))
      end
      @table[i-1][i] = c
    end
  end

  def parse
    (2..@words.length).each do |k|
      (0..k-2).to_a.reverse.each do |r|
        (1..k-1).each do |c|
          puts "k = #{k}"
          puts "(#{r},#{c}) + (#{c},#{k}) : #{(@table[r][c].contents.map(&:left))} + #{@table[c][k].contents.map(&:left)}"
          ret = trace(r, c, k)
          @table[r][k].add(ret.contents, ret.nodes)
        end
      end
    end
  end

  def trace(r, c, k)
    cel1 = @table[r][c]
    cel2 = @table[c][k]
    cell = Cell.new
    if cel1&.contents.blank?
      cel2.contents.each_with_index do |c2, index|
        r = Rule.find_by_right(c2.left)
        cell.add(r.left, Node.new(cel1.nodes[index], nil, r.left, nil, r.freq)) if r.present?
      end
    end

    if cel2&.contents.blank?
      cel1.contents.each_with_index do |c1, index|
        r = Rule.find_by_right(c1.left)
        cell.add(r.left, Node.new(cel2.nodes[index], nil, r.left, nil, r.freq)) if r.present?
      end
    end

    if cel1&.contents.present? && cel2&.contents.present?
      cel1.contents.each_with_index do |c1, index_1|
        cel2.contents.each_with_index do |c2, index_2|
          r = Rule.find_by_right("#{c1.left} #{c2.left}".strip)
          cell.add(r, Node.new(cel1.nodes[index_1], cel2.nodes[index_2], r.left, nil, r.freq)) if r.present?
        end
      end
    end

    return cell
  end

  def pretty
    @table.map { |t| t.map{ |a| a.contents.blank? ? nil : a.contents.map(&:left) }}
  end

  def to_cnf
    cnf = []
    nodes = @table[0].last.nodes.select { |n| n.type == 'S' }
    nodes.each do |node|
      cnf << [unfold(node), tree_freq(node).round(7)]
    end
    return cnf
  end

  def unfold(node)
    # Check for a terminal
    if node.left.nil? and node.right.nil?
        return "#{node.type}(#{node.word})"
    end
    return "#{node.type}(#{unfold(node.left)} #{unfold(node.right)})"
  end

  def tree_freq(node)
    if node.left.nil? and node.right.nil?
        return node.freq
    end
    return tree_freq(node.left) * tree_freq(node.right) * node.freq
  end
end
