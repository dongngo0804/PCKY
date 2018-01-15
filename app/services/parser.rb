class Parser
  def initialize(sentence)
    @raw = sentence
    @parsed = sentence.convert_to_hash
  end

  def parse
    @parsed
  end

  def tokens
    @parsed.all_keys + @parsed.all_values
  end

  def terminals
    @parsed.all_values
  end

  def non_terminals
    @parsed.all_keys
  end
end
