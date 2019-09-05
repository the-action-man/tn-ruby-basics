vowels = {}
vowels['a'] = nil
vowels['e'] = nil
vowels['i'] = nil
vowels['o'] = nil
vowels['u'] = nil

alphabet = 'a'..'z'
alphabet.each.with_index(1) do |letter, position|
  vowels[letter] = position if vowels.include? letter
end
