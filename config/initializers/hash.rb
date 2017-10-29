class Hash
	def recursive_keys(data)
	  data.keys.map(&:to_s) + data.values.flatten.map{|value| recursive_keys(value) if value.is_a?(Hash) }
	end

	def all_keys
	  recursive_keys(self).flatten.compact.uniq
	end 

	def all_values
		values = []
		self.values.flatten.each do |val|
			if val.is_a?(Hash)
				values << val.all_values
			else
				values << val.to_s
			end
		end
		values.flatten.uniq.compact
	end
end