class Cky
  def initialize(Rules, log, model)
    self.@Rules = Rules
    self.@log = log
    self.@model = model
  end

  def find_str_AinB(key, i, j)
    result = []
    Rules.each do |rule| #chua hieu lam
      result.push(rule.left) if rule.right == key
    end
    result
  end

  def add_to_cell(cell1, cell2)
    result = []
    for i in 0...cell1.size
      for j in 0...cell2.size
        found = find_str_AinB((cell1[i] + " " + cell2[j]).to_s, i , j)
        result = result + found
      end
    end
    result
  end

  def runCKY(table, table_row, table_col)
    for k in 2..table_row
      row = k -2
      until row >= 0
        for col in 1...k
          found = add_to_cell(table[row][col].contents, table[col][k].contents)
          table[row][k].contents.addAll(found);
          if !found.empty?
              table[row][k].row = row;
              table[row][k].col = k;
          end
        end
      end
    end
  end
end