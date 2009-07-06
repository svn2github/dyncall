dynbind("winmm", "PlaySoundA(Zii)v;")
tada <- paste( Sys.getenv("SystemRoot"), "\\Media\\tada.wav", sep="" )
PlaySoundA(tada,0,0)

