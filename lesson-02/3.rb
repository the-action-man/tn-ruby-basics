a = [0]
next_number = 1
i = 1

while next_number < 101
  a << next_number
  next_number = a[i - 1] + a[i]
  i += 1
end
