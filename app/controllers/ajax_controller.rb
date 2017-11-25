class AjaxController < ApplicationController
  def add_rules
    cnf = params[:cnf]
    @rules = Rule.all.sort_by(&:left).reverse
    p = Parser.new(cnf)
    sentence = Sentence.find_or_initialize_by(raw: cnf.strip)
    sentence.parsed = p.parse
    sentence.terminal = p.terminals
    sentence.non_terminal = p.non_terminals
    sentence.tokens = p.tokens
    sentence.save!

    sentence.parsed.all_childs.each do |r|
      code = "#{r.lhs.first} -> #{r.rhs.first} #{r.rhs.second.presence}".strip
      rule = Rule.find_or_initialize_by(code: code)
      rule.count += 1
      rule.left = r.lhs.join(' ')
      rule.right = r.rhs.join(' ')
      rule.save!
    end
  end

  
end 