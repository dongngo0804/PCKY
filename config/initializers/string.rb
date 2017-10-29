class String
	def convert_to_hash
		 # :S => [{:NP => [{:NNP => [{nam}]}], {:VP => [{:VB => [{hoc}, :NP]]
		eval("{:#{self.gsub(' ','},{:').gsub('(', '=> [{:').gsub(')','}]').gsub(/{:([\w]+)}/,":\\1")}}")
	end
end