class Rule < ApplicationRecord

  def total
    Rule.where(left: left).pluck(:count).inject(0){ |sum,x| sum + x }
  end
end