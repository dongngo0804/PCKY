class Cell
  attr_accessor :contents, :row, :col
  def initialize()
    @row = -1
    @col = -1
    @contents = []
  end

  def add(ter)
    return if @contents.include? ter
    @contents << ter
    @contents.flatten!
  end

  def self.trace(cel1, cel2)
    c = Cell.new

    if cel1&.contents.blank?
      cel2.contents.each do |c2|
        r = Rule.find_by_right(c2.strip)
        c.add(r.left) if r.present?
      end
    end

    if cel2&.contents.blank?
      cel1.contents.each do |c1|
        r = Rule.find_by_right(c1.strip)
        c.add(r.left) if r.present?
      end
    end

    if cel1&.contents.present? && cel2&.contents.present?
      cel1.contents.each do |c1|
        cel2.contents.each do |c2|
          r = Rule.find_by_right("#{c1} #{c2}".strip)
          c.add(r.left) if r.present?
        end
      end
    end

    return c
  end
end
