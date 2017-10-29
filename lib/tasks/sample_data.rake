namespace :sample_data do
  desc "Generate sample data"
  task :generate => :environment do
    file_path = File.join(Rails.public_path, "sample.txt")
    File.open(file_path, "r").each_line do |line|
      p = Parser.new(line)
      sentence = Sentence.find_or_initialize_by(raw: line.strip)
      sentence.parsed = p.parse
      sentence.terminal = p.terminals
      sentence.non_terminal = p.non_terminals
      sentence.tokens = p.tokens
      sentence.save
    end
  end
 end
  