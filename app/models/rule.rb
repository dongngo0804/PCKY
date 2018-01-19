class Rule < ApplicationRecord

  def total
    Rule.where(left: left).pluck(:count).inject(0){ |sum,x| sum + x }
  end

  def freq
    (self.count / self.total.to_f).round(2)
  end
end
