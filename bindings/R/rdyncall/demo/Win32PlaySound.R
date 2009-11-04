# Package: rdyncall 
# File: demo/Win32PlaySound.R
# Description: Win32 Demo, playing a wav file (dynbind demo)
# Author: Daniel Adler

dynbind("winmm", "PlaySoundA(Zii)v;", callmode="stdcall")
tada <- paste( Sys.getenv("SystemRoot"), "\\Media\\tada.wav", sep="" )
PlaySoundA(tada,0,0)

