class Sentence < ApplicationRecord
   serialize :parsed, Hash
   serialize :tokens, Array
   serialize :terminal, Array
   serialize :non_terminal, Array
end
