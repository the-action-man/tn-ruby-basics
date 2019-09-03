h = Hash.new
h["a"] = nil
h["e"] = nil
h["i"] = nil
h["o"] = nil
h["u"] = nil

number = 1
for i in "a".."z"
  if h.key? i
    h[i] = number
  end
  number += 1
end
