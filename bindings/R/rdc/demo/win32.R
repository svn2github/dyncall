# example: message box on windows

h <- rdcLoad("user32")
f <- rdcFind(h,"MessageBoxA")
rdcCall(f,"ippi)v",0,"hallo","welt",0)
rdcFree(h)

# example: play sound

lib.winmm <- dyn.load("\\windows\\system32\\winmm.dll")
PlaySound <- lib.winmm$PlaySound$Address
sample <- "\\windows\\Media\\start.wav"
rdcCall(PlaySound,"Sii)B",sample,0,0)

