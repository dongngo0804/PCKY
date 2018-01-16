class Cky
  attr_accessor :words, :table

  def initialize(sentence)
    @words = sentence.strip.split(' ')
    @table = Array.new(@words.length){ Array.new(@words.length + 1){ Cell.new } }
    add_words_to_table
  end

  def add_words_to_table
    for i in 1..@words.length do
      c = Cell.new
      r = Rule.find_by_right(@words[i-1])
      c.add(r)
      @table[i-1][i] = c
    end
  end

  def parse
    (2..@words.length).each do |k|
      (0..k-2).to_a.reverse.each do |r|
        (1..k-1).each do |c|
          puts "k = #{k}"
          puts "(#{r},#{c}) + (#{c},#{k}) : #{(@table[r][c].contents.map(&:left))} + #{@table[c][k].contents.map(&:left)}"
          @table[r][k].add(Cell.trace(@table[r][c], @table[c][k]).contents)
        end
      end
    end
  end

  def runCKY(table, table_row, table_col)
    for k in 2..table_row
      row = k -2
      until row >= 0
        for col in 1...k
          found = add_to_cell(table[row][col].contents, table[col][k].contents)
          table[row][k].contents.addAll(found);
          if !found.empty?
              table[row][k].row = row;l;
              table[row][k].col = k;
          end
        end
      end
    end
  end

  def pretty
    @table.map { |t| t.map{ |a| a.contents.blank? ? nil : a.contents.map(&:left) }}
  end
end
