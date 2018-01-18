namespace :sample_data do
  desc "Generate sample data"
  task :generate => :environment do
    file_path = File.join(Rails.public_path, "sample.txt")
    Rule.delete_all
    File.open(file_path, "r").each_line do |line|
      p = Parser.new(line)
      sentence = Sentence.find_or_initialize_by(raw: line.strip)
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
end
  
