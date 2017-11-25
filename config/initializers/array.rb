class Array
  def keys
    self.map do |h|
      if h.is_a?(Hash)
        h.keys
      else
        nil
      end
    end.compact
  end
end