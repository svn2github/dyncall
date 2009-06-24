# Dynport: sdl
# Description: Simple Directmedia Layer library
# Dynport-Maintainer: dadler@uni-goettingen.de
# -----------------------------------------------------------------------------

# bind SDL functions:
dynbind("SDL","
SDL_AddTimer(Ipp)p;
SDL_AllocRW()p;
SDL_AudioDriverName(pi)p;
SDL_AudioInit(p)i;
SDL_AudioQuit()v;
SDL_BuildAudioCVT(pSCiSCi)i;
SDL_CDClose(p)v;
SDL_CDEject(p)i;
SDL_CDName(i)p;
SDL_CDNumDrives()i;
SDL_CDOpen(i)p;
SDL_CDPause(p)i;
SDL_CDPlay(pii)i;
SDL_CDPlayTracks(piiii)i;
SDL_CDResume(p)i;
SDL_CDStatus(p)i;
SDL_CDStop(p)i;
SDL_ClearError()v;
SDL_CloseAudio()v;
SDL_CondBroadcast(p)i;
SDL_CondSignal(p)i;
SDL_CondWait(pp)i;
SDL_CondWaitTimeout(ppI)i;
SDL_ConvertAudio(p)i;
SDL_ConvertSurface(ppI)p;
SDL_CreateCond()p;
SDL_CreateCursor(ppiiii)p;
SDL_CreateMutex()p;
SDL_CreateRGBSurface(IiiiIIII)p;
SDL_CreateRGBSurfaceFrom(piiiiIIII)p;
SDL_CreateSemaphore(I)p;
SDL_CreateThread(pp)p;
SDL_CreateYUVOverlay(iiIp)p;
SDL_Delay(I)v;
SDL_DestroyCond(p)v;
SDL_DestroyMutex(p)v;
SDL_DestroySemaphore(p)v;
SDL_DisplayFormat(p)p;
SDL_DisplayFormatAlpha(p)p;
SDL_DisplayYUVOverlay(pp)i;
SDL_EnableKeyRepeat(ii)i;
SDL_EnableUNICODE(i)i;
SDL_Error(i)v;
SDL_EventState(Ci)C;
SDL_FillRect(ppI)i;
SDL_Flip(p)i;
SDL_FreeCursor(p)v;
SDL_FreeRW(p)v;
SDL_FreeSurface(p)v;
SDL_FreeWAV(p)v;
SDL_FreeYUVOverlay(p)v;
SDL_GL_GetAttribute(ip)i;
SDL_GL_GetProcAddress(p)p;
SDL_GL_LoadLibrary(p)i;
SDL_GL_Lock()v;
SDL_GL_SetAttribute(ii)i;
SDL_GL_SwapBuffers()v;
SDL_GL_Unlock()v;
SDL_GL_UpdateRects(ip)v;
SDL_GetAppState()C;
SDL_GetAudioStatus()i;
SDL_GetClipRect(pp)v;
SDL_GetCursor()p;
SDL_GetError()p;
SDL_GetEventFilter()p;
SDL_GetGammaRamp(ppp)i;
SDL_GetKeyName(i)p;
SDL_GetKeyRepeat(pp)v;
SDL_GetKeyState(p)p;
SDL_GetModState()i;
SDL_GetMouseState(pp)C;
SDL_GetRGB(Ipppp)v;
SDL_GetRGBA(Ippppp)v;
SDL_GetRelativeMouseState(pp)C;
SDL_GetThreadID(p)I;
SDL_GetTicks()I;
SDL_GetVideoInfo()p;
SDL_GetVideoSurface()p;
SDL_Has3DNow()i;
SDL_Has3DNowExt()i;
SDL_HasAltiVec()i;
SDL_HasMMX()i;
SDL_HasMMXExt()i;
SDL_HasRDTSC()i;
SDL_HasSSE()i;
SDL_HasSSE2()i;
SDL_Init(I)i;
SDL_InitSubSystem(I)i;
SDL_JoystickClose(p)v;
SDL_JoystickEventState(i)i;
SDL_JoystickGetAxis(pi)s;
SDL_JoystickGetBall(pipp)i;
SDL_JoystickGetButton(pi)C;
SDL_JoystickGetHat(pi)C;
SDL_JoystickIndex(p)i;
SDL_JoystickName(i)p;
SDL_JoystickNumAxes(p)i;
SDL_JoystickNumBalls(p)i;
SDL_JoystickNumButtons(p)i;
SDL_JoystickNumHats(p)i;
SDL_JoystickOpen(i)p;
SDL_JoystickOpened(i)i;
SDL_JoystickUpdate()v;
SDL_KillThread(p)v;
SDL_Linked_Version()p;
SDL_ListModes(pI)p;
SDL_LoadBMP_RW(pi)p;
SDL_LoadFunction(pp)p;
SDL_LoadObject(p)p;
SDL_LoadWAV_RW(pippp)p;
SDL_LockAudio()v;
SDL_LockSurface(p)i;
SDL_LockYUVOverlay(p)i;
SDL_LowerBlit(pppp)i;
SDL_MapRGB(pCCC)I;
SDL_MapRGBA(pCCCC)I;
SDL_MixAudio(ppIi)v;
SDL_NumJoysticks()i;
SDL_OpenAudio(pp)i;
SDL_PauseAudio(i)v;
SDL_PeepEvents(piiI)i;
SDL_PollEvent(p)i;
SDL_PumpEvents()v;
SDL_PushEvent(p)i;
SDL_Quit()v;
SDL_QuitSubSystem(I)v;
SDL_RWFromConstMem(pi)p;
SDL_RWFromFP(pi)p;
SDL_RWFromFile(pp)p;
SDL_RWFromMem(pi)p;
SDL_ReadBE16(p)S;
SDL_ReadBE32(p)I;
SDL_ReadBE64(p)J;
SDL_ReadLE16(p)S;
SDL_ReadLE32(p)I;
SDL_ReadLE64(p)J;
SDL_RemoveTimer(p)i;
SDL_SaveBMP_RW(ppi)i;
SDL_SemPost(p)i;
SDL_SemTryWait(p)i;
SDL_SemValue(p)I;
SDL_SemWait(p)i;
SDL_SemWaitTimeout(pI)i;
SDL_SetAlpha(pIC)i;
SDL_SetClipRect(pp)i;
SDL_SetColorKey(pII)i;
SDL_SetColors(ppii)i;
SDL_SetCursor(p)v;
SDL_SetError(p)v;
SDL_SetEventFilter(p)v;
SDL_SetGamma(fff)i;
SDL_SetGammaRamp(ppp)i;
SDL_SetModState(i)v;
SDL_SetPalette(pipii)i;
SDL_SetTimer(Ip)i;
SDL_SetVideoMode(iiiI)p;
SDL_ShowCursor(i)i;
SDL_SoftStretch(pppp)i;
SDL_Swap16(S)S;
SDL_Swap32(I)I;
SDL_Swap64(J)J;
SDL_ThreadID()I;
SDL_UnloadObject(p)v;
SDL_UnlockAudio()v;
SDL_UnlockSurface(p)v;
SDL_UnlockYUVOverlay(p)v;
SDL_UpdateRect(piiII)v;
SDL_UpdateRects(pip)v;
SDL_UpperBlit(pppp)i;
SDL_VideoDriverName(pi)p;
SDL_VideoInit(pI)i;
SDL_VideoModeOK(iiiI)i;
SDL_VideoQuit()v;
SDL_WM_GetCaption(pp)v;
SDL_WM_GrabInput(i)i;
SDL_WM_IconifyWindow()i;
SDL_WM_SetCaption(pp)v;
SDL_WM_SetIcon(pp)v;
SDL_WM_ToggleFullScreen(p)i;
SDL_WaitEvent(p)i;
SDL_WaitThread(pp)v;
SDL_WarpMouse(SS)v;
SDL_WasInit(I)I;
SDL_WriteBE16(pS)i;
SDL_WriteBE32(pI)i;
SDL_WriteBE64(pJ)i;
SDL_WriteLE16(pS)i;
SDL_WriteLE32(pI)i;
SDL_WriteLE64(pJ)i;
SDL_iconv(ppppp)J;
SDL_iconv_string(pppJ)p;
SDL_lltoa(jpi)p;
SDL_ltoa(jpi)p;
SDL_mutexP(p)i;
SDL_mutexV(p)i;
SDL_revcpy(ppJ)p;
SDL_strlcat(ppJ)J;
SDL_strlcpy(ppJ)J;
SDL_strlwr(p)p;
SDL_strrev(p)p;
SDL_strupr(p)p;
SDL_ulltoa(Jpi)p;
SDL_ultoa(Jpi)p;
")

# -----------------------------------------------------------------------------
# macro defines:

SDL_ALLEVENTS=0xFFFFFFFF
SDL_ALL_HOTKEYS=0xFFFFFFFF
SDL_ALPHA_OPAQUE=255
SDL_ALPHA_TRANSPARENT=0
SDL_ANYFORMAT=0x10000000
SDL_APPACTIVE=0x04
SDL_APPINPUTFOCUS=0x02
SDL_APPMOUSEFOCUS=0x01
SDL_ASSEMBLY_ROUTINES=1
SDL_ASYNCBLIT=0x00000004
SDL_AUDIO_DRIVER_ALSA=1
SDL_AUDIO_DRIVER_ALSA_DYNAMIC="libasound.so.2"
SDL_AUDIO_DRIVER_DISK=1
SDL_AUDIO_DRIVER_DUMMY=1
SDL_AUDIO_TRACK=0x00
SDL_AllocSurface=SDL_CreateRGBSurface
SDL_BIG_ENDIAN=4321
SDL_BUTTON_LEFT=1
#SDL_BUTTON_LMASK=(1 << ((1)-1))
SDL_BUTTON_MIDDLE=2
#SDL_BUTTON_MMASK=(1 << ((2)-1))
SDL_BUTTON_RIGHT=3
#SDL_BUTTON_RMASK=(1 << ((3)-1))
SDL_BUTTON_WHEELDOWN=5
SDL_BUTTON_WHEELUP=4
SDL_BUTTON_X1=6
#SDL_BUTTON_X1MASK=(1 << ((6)-1))
SDL_BUTTON_X2=7
#SDL_BUTTON_X2MASK=(1 << ((7)-1))
SDL_BYTEORDER=1234
SDL_BlitSurface=SDL_UpperBlit
SDL_CDROM_LINUX=1
SDL_COMPILEDVERSION=((1)*1000 + (2)*100 + (13))
#SDL_Colour=SDL_Color
SDL_DATA_TRACK=0x04
SDL_DEFAULT_REPEAT_DELAY=500
SDL_DEFAULT_REPEAT_INTERVAL=30
SDL_DISABLE=0
SDL_DOUBLEBUF=0x40000000
SDL_ENABLE=1
SDL_FULLSCREEN=0x80000000
SDL_HAS_64BIT_TYPE=1
SDL_HAT_CENTERED=0x00
SDL_HAT_DOWN=0x04
SDL_HAT_LEFT=0x08
SDL_HAT_LEFTDOWN=(0x08+0x04)
SDL_HAT_LEFTUP=(0x08+0x01)
SDL_HAT_RIGHT=0x02
SDL_HAT_RIGHTDOWN=(0x02+0x04)
SDL_HAT_RIGHTUP=(0x02+0x01)
SDL_HAT_UP=0x01
SDL_HWACCEL=0x00000100
SDL_HWPALETTE=0x20000000
SDL_HWSURFACE=0x00000001
#SDL_ICONV_E2BIG=(size_t)-2
#SDL_ICONV_EILSEQ=(size_t)-3
#SDL_ICONV_EINVAL=(size_t)-4
#SDL_ICONV_ERROR=(size_t)-1
SDL_IGNORE=0
SDL_INIT_AUDIO=0x00000010
SDL_INIT_CDROM=0x00000100
SDL_INIT_EVENTTHREAD=0x01000000
SDL_INIT_EVERYTHING=0x0000FFFF
SDL_INIT_JOYSTICK=0x00000200
SDL_INIT_NOPARACHUTE=0x00100000
SDL_INIT_TIMER=0x00000001
SDL_INIT_VIDEO=0x00000020
SDL_INLINE_OKAY=
SDL_INPUT_LINUXEV=1
SDL_IYUV_OVERLAY=0x56555949
SDL_JOYSTICK_LINUX=1
SDL_LIL_ENDIAN=1234
SDL_LOADSO_DLOPEN=1
SDL_LOGPAL=0x01
SDL_MAJOR_VERSION=1
SDL_MAX_TRACKS=99
SDL_MINOR_VERSION=2
SDL_MIX_MAXVOLUME=128
#SDL_MUTEX_MAXWAIT=(~(Uint32)0)
SDL_MUTEX_TIMEDOUT=1
SDL_NOFRAME=0x00000020
SDL_OPENGL=0x00000002
SDL_OPENGLBLIT=0x0000000A
SDL_PATCHLEVEL=13
SDL_PHYSPAL=0x02
SDL_PREALLOC=0x01000000
SDL_PRESSED=1
SDL_QUERY=-1
SDL_RELEASED=0
SDL_RESIZABLE=0x00000010
SDL_RLEACCEL=0x00004000
SDL_RLEACCELOK=0x00002000
SDL_SRCALPHA=0x00010000
SDL_SRCCOLORKEY=0x00001000
SDL_SWSURFACE=0x00000000
SDL_THREAD_PTHREAD=1
SDL_THREAD_PTHREAD_RECURSIVE_MUTEX=1
SDL_TIMER_UNIX=1
SDL_TIMESLICE=10
SDL_UYVY_OVERLAY=0x59565955
SDL_VIDEO_DRIVER_DUMMY=1
SDL_VIDEO_DRIVER_X11=1
SDL_VIDEO_DRIVER_X11_DPMS=1
SDL_VIDEO_DRIVER_X11_DYNAMIC="libX11.so.6"
SDL_VIDEO_DRIVER_X11_DYNAMIC_XEXT="libXext.so.6"
SDL_VIDEO_DRIVER_X11_DYNAMIC_XRANDR="libXrandr.so.2"
SDL_VIDEO_DRIVER_X11_DYNAMIC_XRENDER="libXrender.so.1"
SDL_VIDEO_DRIVER_X11_VIDMODE=1
SDL_VIDEO_DRIVER_X11_XRANDR=1
SDL_VIDEO_OPENGL=1
SDL_VIDEO_OPENGL_GLX=1
SDL_YUY2_OVERLAY=0x32595559
SDL_YV12_OVERLAY=0x32315659
SDL_YVYU_OVERLAY=0x55595659
#SDL_abs=abs
#SDL_atof=atof
#SDL_atoi=atoi
#SDL_calloc=calloc
#SDL_free=free
#SDL_getenv=getenv
#SDL_iconv_close=iconv_close
#SDL_iconv_open=iconv_open
#SDL_iconv_t=iconv_t
#SDL_malloc=malloc
#SDL_memcmp=memcmp
#SDL_memcpy=memcpy
#SDL_memmove=memmove
#SDL_memset=memset
#SDL_putenv=putenv
#SDL_qsort=qsort
#SDL_realloc=realloc
#SDL_snprintf=snprintf
#SDL_sscanf=sscanf
#SDL_strcasecmp=strcasecmp
#SDL_strchr=strchr
#SDL_strcmp=strcmp
#SDL_strdup=strdup
#SDL_strlen=strlen
#SDL_strncasecmp=strncasecmp
#SDL_strncmp=strncmp
#SDL_strrchr=strrchr
#SDL_strstr=strstr
#SDL_strtod=strtod
#SDL_strtol=strtol
#SDL_strtoll=strtoll
#SDL_strtoul=strtoul
#SDL_strtoull=strtoull
#SDL_vsnprintf=vsnprintf

# -----------------------------------------------------------------------------
# enums:

CD_ERROR=-1
CD_PAUSED=3
CD_PLAYING=2
CD_STOPPED=1
CD_TRAYEMPTY=0
DUMMY_ENUM_VALUE=0
KMOD_CAPS=8192
KMOD_LALT=256
KMOD_LCTRL=64
KMOD_LMETA=1024
KMOD_LSHIFT=1
KMOD_MODE=16384
KMOD_NONE=0
KMOD_NUM=4096
KMOD_RALT=512
KMOD_RCTRL=128
KMOD_RESERVED=32768
KMOD_RMETA=2048
KMOD_RSHIFT=2
SDLK_0=48
SDLK_1=49
SDLK_2=50
SDLK_3=51
SDLK_4=52
SDLK_5=53
SDLK_6=54
SDLK_7=55
SDLK_8=56
SDLK_9=57
SDLK_AMPERSAND=38
SDLK_ASTERISK=42
SDLK_AT=64
SDLK_BACKQUOTE=96
SDLK_BACKSLASH=92
SDLK_BACKSPACE=8
SDLK_BREAK=318
SDLK_CAPSLOCK=301
SDLK_CARET=94
SDLK_CLEAR=12
SDLK_COLON=58
SDLK_COMMA=44
SDLK_COMPOSE=314
SDLK_DELETE=127
SDLK_DOLLAR=36
SDLK_DOWN=274
SDLK_END=279
SDLK_EQUALS=61
SDLK_ESCAPE=27
SDLK_EURO=321
SDLK_EXCLAIM=33
SDLK_F10=291
SDLK_F11=292
SDLK_F12=293
SDLK_F13=294
SDLK_F14=295
SDLK_F15=296
SDLK_F1=282
SDLK_F2=283
SDLK_F3=284
SDLK_F4=285
SDLK_F5=286
SDLK_F6=287
SDLK_F7=288
SDLK_F8=289
SDLK_F9=290
SDLK_FIRST=0
SDLK_GREATER=62
SDLK_HASH=35
SDLK_HELP=315
SDLK_HOME=278
SDLK_INSERT=277
SDLK_KP0=256
SDLK_KP1=257
SDLK_KP2=258
SDLK_KP3=259
SDLK_KP4=260
SDLK_KP5=261
SDLK_KP6=262
SDLK_KP7=263
SDLK_KP8=264
SDLK_KP9=265
SDLK_KP_DIVIDE=267
SDLK_KP_ENTER=271
SDLK_KP_EQUALS=272
SDLK_KP_MINUS=269
SDLK_KP_MULTIPLY=268
SDLK_KP_PERIOD=266
SDLK_KP_PLUS=270
SDLK_LALT=308
SDLK_LAST=323
SDLK_LCTRL=306
SDLK_LEFT=276
SDLK_LEFTBRACKET=91
SDLK_LEFTPAREN=40
SDLK_LESS=60
SDLK_LMETA=310
SDLK_LSHIFT=304
SDLK_LSUPER=311
SDLK_MENU=319
SDLK_MINUS=45
SDLK_MODE=313
SDLK_NUMLOCK=300
SDLK_PAGEDOWN=281
SDLK_PAGEUP=280
SDLK_PAUSE=19
SDLK_PERIOD=46
SDLK_PLUS=43
SDLK_POWER=320
SDLK_PRINT=316
SDLK_QUESTION=63
SDLK_QUOTE=39
SDLK_QUOTEDBL=34
SDLK_RALT=307
SDLK_RCTRL=305
SDLK_RETURN=13
SDLK_RIGHT=275
SDLK_RIGHTBRACKET=93
SDLK_RIGHTPAREN=41
SDLK_RMETA=309
SDLK_RSHIFT=303
SDLK_RSUPER=312
SDLK_SCROLLOCK=302
SDLK_SEMICOLON=59
SDLK_SLASH=47
SDLK_SPACE=32
SDLK_SYSREQ=317
SDLK_TAB=9
SDLK_UNDERSCORE=95
SDLK_UNDO=322
SDLK_UNKNOWN=0
SDLK_UP=273
SDLK_WORLD_0=160
SDLK_WORLD_10=170
SDLK_WORLD_11=171
SDLK_WORLD_12=172
SDLK_WORLD_13=173
SDLK_WORLD_14=174
SDLK_WORLD_15=175
SDLK_WORLD_16=176
SDLK_WORLD_17=177
SDLK_WORLD_18=178
SDLK_WORLD_19=179
SDLK_WORLD_1=161
SDLK_WORLD_20=180
SDLK_WORLD_21=181
SDLK_WORLD_22=182
SDLK_WORLD_23=183
SDLK_WORLD_24=184
SDLK_WORLD_25=185
SDLK_WORLD_26=186
SDLK_WORLD_27=187
SDLK_WORLD_28=188
SDLK_WORLD_29=189
SDLK_WORLD_2=162
SDLK_WORLD_30=190
SDLK_WORLD_31=191
SDLK_WORLD_32=192
SDLK_WORLD_33=193
SDLK_WORLD_34=194
SDLK_WORLD_35=195
SDLK_WORLD_36=196
SDLK_WORLD_37=197
SDLK_WORLD_38=198
SDLK_WORLD_39=199
SDLK_WORLD_3=163
SDLK_WORLD_40=200
SDLK_WORLD_41=201
SDLK_WORLD_42=202
SDLK_WORLD_43=203
SDLK_WORLD_44=204
SDLK_WORLD_45=205
SDLK_WORLD_46=206
SDLK_WORLD_47=207
SDLK_WORLD_48=208
SDLK_WORLD_49=209
SDLK_WORLD_4=164
SDLK_WORLD_50=210
SDLK_WORLD_51=211
SDLK_WORLD_52=212
SDLK_WORLD_53=213
SDLK_WORLD_54=214
SDLK_WORLD_55=215
SDLK_WORLD_56=216
SDLK_WORLD_57=217
SDLK_WORLD_58=218
SDLK_WORLD_59=219
SDLK_WORLD_5=165
SDLK_WORLD_60=220
SDLK_WORLD_61=221
SDLK_WORLD_62=222
SDLK_WORLD_63=223
SDLK_WORLD_64=224
SDLK_WORLD_65=225
SDLK_WORLD_66=226
SDLK_WORLD_67=227
SDLK_WORLD_68=228
SDLK_WORLD_69=229
SDLK_WORLD_6=166
SDLK_WORLD_70=230
SDLK_WORLD_71=231
SDLK_WORLD_72=232
SDLK_WORLD_73=233
SDLK_WORLD_74=234
SDLK_WORLD_75=235
SDLK_WORLD_76=236
SDLK_WORLD_77=237
SDLK_WORLD_78=238
SDLK_WORLD_79=239
SDLK_WORLD_7=167
SDLK_WORLD_80=240
SDLK_WORLD_81=241
SDLK_WORLD_82=242
SDLK_WORLD_83=243
SDLK_WORLD_84=244
SDLK_WORLD_85=245
SDLK_WORLD_86=246
SDLK_WORLD_87=247
SDLK_WORLD_88=248
SDLK_WORLD_89=249
SDLK_WORLD_8=168
SDLK_WORLD_90=250
SDLK_WORLD_91=251
SDLK_WORLD_92=252
SDLK_WORLD_93=253
SDLK_WORLD_94=254
SDLK_WORLD_95=255
SDLK_WORLD_9=169
SDLK_a=97
SDLK_b=98
SDLK_c=99
SDLK_d=100
SDLK_e=101
SDLK_f=102
SDLK_g=103
SDLK_h=104
SDLK_i=105
SDLK_j=106
SDLK_k=107
SDLK_l=108
SDLK_m=109
SDLK_n=110
SDLK_o=111
SDLK_p=112
SDLK_q=113
SDLK_r=114
SDLK_s=115
SDLK_t=116
SDLK_u=117
SDLK_v=118
SDLK_w=119
SDLK_x=120
SDLK_y=121
SDLK_z=122
SDL_ACTIVEEVENT=1
SDL_ACTIVEEVENTMASK=2
SDL_ADDEVENT=0
SDL_AUDIO_PAUSED=2
SDL_AUDIO_PLAYING=1
SDL_AUDIO_STOPPED=0
SDL_EFREAD=1
SDL_EFSEEK=3
SDL_EFWRITE=2
SDL_ENOMEM=0
SDL_EVENT_RESERVED2=18
SDL_EVENT_RESERVED3=19
SDL_EVENT_RESERVED4=20
SDL_EVENT_RESERVED5=21
SDL_EVENT_RESERVED6=22
SDL_EVENT_RESERVED7=23
SDL_EVENT_RESERVEDA=14
SDL_EVENT_RESERVEDB=15
SDL_FALSE=0
SDL_GETEVENT=2
SDL_GL_ACCELERATED_VISUAL=15
SDL_GL_ACCUM_ALPHA_SIZE=11
SDL_GL_ACCUM_BLUE_SIZE=10
SDL_GL_ACCUM_GREEN_SIZE=9
SDL_GL_ACCUM_RED_SIZE=8
SDL_GL_ALPHA_SIZE=3
SDL_GL_BLUE_SIZE=2
SDL_GL_BUFFER_SIZE=4
SDL_GL_DEPTH_SIZE=6
SDL_GL_DOUBLEBUFFER=5
SDL_GL_GREEN_SIZE=1
SDL_GL_MULTISAMPLEBUFFERS=13
SDL_GL_MULTISAMPLESAMPLES=14
SDL_GL_RED_SIZE=0
SDL_GL_STENCIL_SIZE=7
SDL_GL_STEREO=12
SDL_GL_SWAP_CONTROL=16
SDL_GRAB_FULLSCREEN=2
SDL_GRAB_OFF=0
SDL_GRAB_ON=1
SDL_GRAB_QUERY=-1
SDL_JOYAXISMOTION=7
SDL_JOYAXISMOTIONMASK=128
SDL_JOYBALLMOTION=8
SDL_JOYBALLMOTIONMASK=256
SDL_JOYBUTTONDOWN=10
SDL_JOYBUTTONDOWNMASK=1024
SDL_JOYBUTTONUP=11
SDL_JOYBUTTONUPMASK=2048
SDL_JOYEVENTMASK=3968
SDL_JOYHATMOTION=9
SDL_JOYHATMOTIONMASK=512
SDL_KEYDOWN=2
SDL_KEYDOWNMASK=4
SDL_KEYEVENTMASK=12
SDL_KEYUP=3
SDL_KEYUPMASK=8
SDL_LASTERROR=5
SDL_MOUSEBUTTONDOWN=5
SDL_MOUSEBUTTONDOWNMASK=32
SDL_MOUSEBUTTONUP=6
SDL_MOUSEBUTTONUPMASK=64
SDL_MOUSEEVENTMASK=112
SDL_MOUSEMOTION=4
SDL_MOUSEMOTIONMASK=16
SDL_NOEVENT=0
SDL_NUMEVENTS=32
SDL_PEEKEVENT=1
SDL_QUIT=12
SDL_QUITMASK=4096
SDL_SYSWMEVENT=13
SDL_SYSWMEVENTMASK=8192
SDL_TRUE=1
SDL_UNSUPPORTED=4
SDL_USEREVENT=24
SDL_VIDEOEXPOSE=17
SDL_VIDEOEXPOSEMASK=131072
SDL_VIDEORESIZE=16
SDL_VIDEORESIZEMASK=65536

# -----------------------------------------------------------------------------
# structs:
parseStructInfos("
_SDL_TimerID{};
")
# SDL_CD{iiiii}id status numtracks cur_track cur_frame track ;
# SDL_AudioCVT{iSSd*Ciiidi}needed src_format dst_format rate_incr buf len len_cvt len_mult len_ratio filters filter_index ;
# SDL_Overlay{Iiii*S**<private_yuvhwfuncs>*<private_yuvhwdata>II}format w h planes pitches pixels hwfuncs hwdata hw_overlay UnusedBits ;
# SDL_Cursor{<SDL_Rect>ss*C*C*<WMcursor>}area hot_x hot_y data mask save wm_cursor ;

parseStructInfos("
SDL_version{CCC}major minor patch ;
_SDL_TimerID{};
SDL_SysWMmsg{};
SDL_SysWMEvent{C*<SDL_SysWMmsg>}type msg ;  
SDL_UserEvent{Ci*v*v}type code data1 data2 ;
SDL_QuitEvent{C}type ;
SDL_ExposeEvent{C}type ;
SDL_ResizeEvent{Cii}type w h ;
SDL_JoyButtonEvent{CCCC}type which button state ;
SDL_JoyHatEvent{CCCC}type which hat value ;
SDL_JoyBallEvent{CCCss}type which ball xrel yrel ;
SDL_JoyAxisEvent{CCCs}type which axis value ;
SDL_MouseButtonEvent{CCCCSS}type which button state x y ;
SDL_MouseMotionEvent{CCCSSss}type which state x y xrel yrel ;
SDL_keysym{CiiS}scancode sym mod unicode ;
SDL_KeyboardEvent{CCC<SDL_keysym>}type which state keysym ;
SDL_ActiveEvent{CCC}type gain state ;
_SDL_Joystick{};
SDL_Rect{ssSS}x y w h ;
WMcursor{};
SDL_AudioSpec{iSCCSSI*p*v}freq format channels silence samples padding size callback userdata ;
private_yuvhwdata{};
private_yuvhwfuncs{};
SDL_Color{CCCC}r g b unused ;
SDL_Palette{i*<SDL_Color>}ncolors colors ;
SDL_PixelFormat{*<SDL_Palette>CCCCCCCCCCIIIIIC}palette BitsPerPixel BytesPerPixel Rloss Gloss Bloss Aloss Rshift Gshift Bshift Ashift Rmask Gmask Bmask Amask colorkey alpha ;
SDL_VideoInfo{IIIIIIIIIIIII*<SDL_PixelFormat>ii}hw_available wm_available UnusedBits1 UnusedBits2 blit_hw blit_hw_CC blit_hw_A blit_sw blit_sw_CC blit_sw_A blit_fill UnusedBits3 video_mem vfmt current_w current_h ;
SDL_Surface{I*<SDL_PixelFormat>iiS*vi*<private_hwdata><SDL_Rect>II*<SDL_BlitMap>Ii}flags format w h pitch pixels offset hwdata clip_rect unused1 locked map format_version refcount ;
SDL_BlitMap{};
private_hwdata{};
SDL_CDtrack{CCSII}id type unused length offset ;
SDL_Thread{};
SDL_cond{};
SDL_semaphore{};
SDL_mutex{};
")

parseUnionInfos("
SDL_Event|C<SDL_ActiveEvent><SDL_KeyboardEvent><SDL_MouseMotionEvent><SDL_MouseButtonEvent><SDL_JoyAxisEvent><SDL_JoyBallEvent><SDL_JoyHatEvent><SDL_JoyButtonEvent><SDL_ResizeEvent><SDL_ExposeEvent><SDL_QuitEvent><SDL_UserEvent><SDL_SysWMEvent>}type active key motion button jaxis jball jhat jbutton resize expose quit user syswm ;
")

# deprecated:

quote({
# init flags:

SDL_INIT_TIMER		   = 0x00000001
SDL_INIT_AUDIO		   = 0x00000010
SDL_INIT_VIDEO		   = 0x00000020
SDL_INIT_CDROM		   = 0x00000100
SDL_INIT_JOYSTICK	   = 0x00000200
SDL_INIT_NOPARACHUTE = 0x00100000
SDL_INIT_EVENTTHREAD = 0x01000000
SDL_INIT_EVERYTHING	 = 0x0000FFFF

# video flags:

SDL_SWSURFACE	  = 0x00000000
SDL_HWSURFACE	  = 0x00000001
SDL_ASYNCBLIT	  = 0x00000004
SDL_ANYFORMAT	  = 0x10000000
SDL_HWPALETTE	  = 0x20000000
SDL_DOUBLEBUF	  = 0x40000000
SDL_FULLSCREEN	= 0x80000000
SDL_OPENGL      = 0x00000002
SDL_OPENGLBLIT	= 0x0000000A
SDL_RESIZABLE	  = 0x00000010
SDL_NOFRAME	    = 0x00000020
SDL_HWACCEL	    = 0x00000100
SDL_SRCCOLORKEY	= 0x00001000
SDL_RLEACCELOK	= 0x00002000
SDL_RLEACCEL	  = 0x00004000
SDL_SRCALPHA	  = 0x00010000
SDL_PREALLOC	  = 0x01000000

# event ids:

SDL_NOEVENT         = 0
SDL_ACTIVEEVENT     = 1
SDL_KEYDOWN         = 2
SDL_KEYUP           = 3
SDL_MOUSEMOTION     = 4 
SDL_MOUSEBUTTONDOWN = 5
SDL_MOUSEBUTTONUP   = 6
SDL_JOYAXISMOTION   = 7
SDL_JOYBALLMOTION   = 8
SDL_JOYHATMOTION    = 9
SDL_JOYBUTTONDOWN   = 10
SDL_JOYBUTTONUP     = 11
SDL_QUIT            = 12
SDL_SYSWMEVENT      = 13
SDL_EVENT_RESERVEDA = 14
SDL_EVENT_RESERVEDB = 15
SDL_VIDEORESIZE     = 16
SDL_VIDEOEXPOSE     = 17
SDL_EVENT_RESERVED2 = 18
SDL_EVENT_RESERVED3 = 19
SDL_EVENT_RESERVED4 = 20
SDL_EVENT_RESERVED5 = 21
SDL_EVENT_RESERVED6 = 22
SDL_EVENT_RESERVED7 = 23
SDL_USEREVENT       = 24
SDL_NUMEVENTS       = 32
})

# -----------------------------------------------------------------------------
# SDL_Event workaround:


sizeof.SDL_Event    = 64

# -----------------------------------------------------------------------------
# bindings:

.commented <- quote({

types <- c(
Uint32 = 'i',
int = 'i',
Uint16 = 'S',
"pointer" = 'p'
)
    
SDL_Surface <- structinfo("
  Uint32 flags;
  pointer format;
  int w;
  int h;
  Uint16 pitch;
  pointer pixels;
",types)

})

quote( dynbind("SDL","
SDL_Init(i)i;
SDL_Quit()v;
SDL_SetVideoMode(iiii)p;
SDL_WM_SetCaption(ZZ)v;
SDL_GL_SwapBuffers()v;
SDL_PollEvent(p)i;
SDL_GetTicks()i;
SDL_Delay(i)v;
") )

# -----------------------------------------------------------------------------
# C structure helpers:

.typemap <- c(
    UINT='I',
    WNDPROC='p',
    int='i',
    HINSTANCE='p',
    HICON='p',
    HCURSOR='p',
    HBRUSH='p',
    LPCTSTR='Z',
    LPCTSTR='Z',
    void='v'
)

SDL_Event.type   <- function(event) .unpack1(event, 0, "c")
SDL_Event.button <- function(event) .unpack1(event, 1, "c")
SDL_Event.gain   <- function(event) .unpack1(event, 1, "c")
SDL_Event.state  <- function(event) .unpack1(event, 2, "c")
SDL_Event.key    <- function(event) .unpack1(event, 3, "i") # need to be tested!

# SDL_ActiveEvent <- .cstruct( type="uint8",gain="uint8",state="uint8")
# SDL_KeyboardEvent <- .cstruct( type="uint8", state="uint8", keysym="SDL_keysym")

new.SDL_event <- function() malloc(sizeof.SDL_Event)

commented <- function() {

structinfo("SDL_ActiveEvent","
  Uint8 type;
  Uint8 gain;
  Uint8 state;
")
structinfo("SDL_KeyboardEvent","
  Uint8 type;
  Uint8 which;
  Uint8 state;
  SDL_keysym keysym;
")
structinfo("SDL_MouseMotionEvent","
  Uint8 type;
  Uint8 which;
  Uint8 state;
  Uint16 x, y;
  Sint16 xrel;
  Sint16 yrel;
")
structinfo("SDL_MouseButtonEvent","
  Uint8 type;
  Uint8 which;
  Uint8 button;
  Uint8 state;
  Uint16 x, y;
")
structinfo("SDL_JoyAxisEvent","
  Uint8 type;
  Uint8 which;
  Uint8 axis;
  Sint16 value;
")
structinfo("SDL_JoyBallEvent","
  Uint8 type;
  Uint8 which;
  Uint8 ball;
  Sint16 xrel;
  Sint16 yrel;
")
structinfo("SDL_JoyHatEvent","
  Uint8 type;
  Uint8 which;
  Uint8 hat;
  Uint8 value;
")
structinfo("SDL_JoyButtonEvent","
  Uint8 type;
  Uint8 which;
  Uint8 button;
  Uint8 state;
")
structinfo("SDL_ResizeEvent","
  Uint8 type;
  int w;
  int h;
")
structinfo("SDL_ExposeEvent","
  Uint8 type;
")
structinfo("SDL_QuitEvent","
  Uint8 type;
")
structinfo("SDL_UserEvent","
  Uint8 type;
  int code;
  void *data1;
  void *data2;
")

unioninfo("SDL_Event","
        Uint8 type;
        SDL_ActiveEvent active;
        SDL_KeyboardEvent key;
        SDL_MouseMotionEvent motion;
        SDL_MouseButtonEvent button;
        SDL_JoyAxisEvent jaxis;
        SDL_JoyBallEvent jball;
        SDL_JoyHatEvent jhat;
        SDL_JoyButtonEvent jbutton;
        SDL_ResizeEvent resize;
        SDL_ExposeEvent expose;
        SDL_QuitEvent quit;
        SDL_UserEvent user;
        SDL_SysWMEvent syswm;
        ")


# struct SDL_SysWMmsg;
# typedef struct SDL_SysWMmsg SDL_SysWMmsg;
structinfo("SDL_SysWMEvent","
  Uint8 type;
  SDL_SysWMmsg *msg;
")



}
