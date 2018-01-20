class String
	def convert_to_hash
    vn_regex = '\wẮẰẲẴẶĂẤẦẨẪẬÂÁÀÃẢẠĐẾỀỂỄỆÊÉÈẺẼẸÍÌỈĨỊỐỒỔỖỘÔỚỜỞỠỢƠÓÒÕỎỌỨỪỬỮỰƯÚÙỦŨỤÝỲỶỸỴắằẳẵặăấầẩẫậâáàãảạđếềểễệêéèẻẽẹíìỉĩịốồổỗộôớờởỡợơóòõỏọứừửữựưúùủũụýỳỷỹỵ'
		 # :S => [{:NP => [{:NNP => [{nam}]}], {:VP => [{:VB => [{hoc}, :NP]]
		eval("{:#{self.gsub(' ','},{:').gsub('(', '=> [{:').gsub(')','}]').gsub(/{:([#{vn_regex}]+)}/,":\\1")}}")
	end

	def convert_to_json
		vn_regex = '\wẮẰẲẴẶĂẤẦẨẪẬÂÁÀÃẢẠĐẾỀỂỄỆÊÉÈẺẼẸÍÌỈĨỊỐỒỔỖỘÔỚỜỞỠỢƠÓÒÕỎỌỨỪỬỮỰƯÚÙỦŨỤÝỲỶỸỴắằẳẵặăấầẩẫậâáàãảạđếềểễệêéèẻẽẹíìỉĩịốồổỗộôớờởỡợơóòõỏọứừửữựưúùủũụýỳỷỹỵ'
		"[" + self.convert_to_hash.to_s.gsub(/\[\:([#{vn_regex}]+)]/,"[{:\\1}]").gsub(':', '"name": ').gsub('=>',', "children": ').gsub(/: ([#{vn_regex}]+)/, ': "\\1"') + "]"
	end
end
