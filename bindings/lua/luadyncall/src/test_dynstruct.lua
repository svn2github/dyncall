require "dynstruct"

regstructinfo("Rect{c x c y c w c h}")
x = newdynstruct("Rect")
print(x.x)
x.x = 257
print(x.x)

