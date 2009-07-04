# Dynport: gl
# Description: OpenGL 1.1
# Maintainer: dadler@uni-goettingen.de

if (.Platform$OS == "windows") {
  .libname <- "OPENGL32"
  .callmode <- "stdcall"
} else {
  .callmode <- "cdecl"
  if ( Sys.info()[["sysname"]] == "Darwin" ) {
    .libname <- "OpenGL"
  } else {
  .libname <- c("GL","GL.so.1")
  }   
}

dynbind(.libname,"
 glAccum(if)v;
 glAlphaFunc(if)v;
 glAreTexturesResident(ipp)B;
 glArrayElement(i)v;
 glBegin(i)v;
 glBindTexture(ii)v;
 glBitmap(iiffffp)v;
 glBlendFunc(ii)v;
 glCallList(i)v;
 glCallLists(iip)v;
 glClear(i )v;
 glClearAccum (f  f  f  f )v;
 glClearColor (f  f  f  f )v;
 glClearDepth (d )v;
 glClearIndex (f )v;
 glClearStencil (i )v;
 glClipPlane (i   p)v;
 glColor3b (c  c  c )v;
 glColor3bv ( p)v;
 glColor3d (d  d  d )v;
 glColor3dv ( p)v;
 glColor3f (f  f  f )v;
 glColor3fv ( p)v;
 glColor3i (i  i  i )v;
 glColor3iv ( p)v;
 glColor3s (s  s  s )v;
 glColor3sv ( p)v;
 glColor3ub (c  c  c )v;
 glColor3ubv ( p)v;
 glColor3ui (i  i  i )v;
 glColor3uiv ( p)v;
 glColor3us (s  s  s )v;
 glColor3usv ( p)v;
 glColor4b (c  c  c  c )v;
 glColor4bv ( p)v;
 glColor4d (d  d  d  d )v;
 glColor4dv ( p)v;
 glColor4f (f  f  f  f )v;
 glColor4fv ( p)v;
 glColor4i (i  i  i  i )v;
 glColor4iv ( p)v;
 glColor4s (s  s  s  s )v;
 glColor4sv ( p)v;
 glColor4ub (c  c  c  c )v;
 glColor4ubv ( p)v;
 glColor4ui (i  i  i  i )v;
 glColor4uiv ( p)v;
 glColor4us (s  s  s  s )v;
 glColor4usv ( p)v;
 glColorMask (B  B  B  B )v;
 glColorMaterial (i  i )v;
 glColorPointer (i  i  i   p)v;
 glCopyPixels (i  i  i  i  i )v;
 glCopyTexImage1D (i  i  i i  i  i  i )v;
 glCopyTexImage2D (i  i  i i  i  i  i  i )v;
 glCopyTexSubImage1D (i  i  i  i  i  i )v;
 glCopyTexSubImage2D (i  i  i  i  i  i  i  i )v;
 glCullFace (i )v;
 glDeleteLists (i  i )v;
 glDeleteTextures (i   p)v;
 glDepthFunc (i )v;
 glDepthMask (B )v;
 glDepthRange (dd)v;
 glDisable (i )v;
 glDisableClientState (i )v;
 glDrawArrays (i  i  i )v;
 glDrawBuffer (i )v;
 glDrawElements (i  i  i   p)v;
 glDrawPixels (i  i  i  i   p)v;
 glEdgeFlag (B )v;
 glEdgeFlagPointer (i   p)v;
 glEdgeFlagv ( p)v;
 glEnable (i )v;
 glEnableClientState (i )v;
 glEnd ()v;
 glEndList ()v;
 glEvalCoord1d (d )v;
 glEvalCoord1dv ( p)v;
 glEvalCoord1f (f )v;
 glEvalCoord1fv ( p)v;
 glEvalCoord2d (d  d )v;
 glEvalCoord2dv ( p)v;
 glEvalCoord2f (f  f )v;
 glEvalCoord2fv ( p)v;
 glEvalMesh1 (i  i  i )v;
 glEvalMesh2 (i  i  i  i  i )v;
 glEvalPoint1 (i )v;
 glEvalPoint2 (i  i )v;
 glFeedbackBuffer (i  i  p)v;
 glFinish ()v;
 glFlush ()v;
 glFogf (i  f )v;
 glFogfv (i   p)v;
 glFogi (i  i )v;
 glFogiv (i   p)v;
 glFrontFace (i )v;
 glFrustum (d  d  d  d  d  d )v;
 glGenLists (i )i;
 glGenTextures (i  p)v;
 glGetBooleanv (i  p)v;
 glGetClipPlane (i  p)v;
 glGetDoublev (i  p)v;
 glGetError ()i;
 glGetFloatv (i  p)v;
 glGetIntegerv (i  p)v;
 glGetLightfv (i  i  p)v;
 glGetLightiv (i  i  p)v;
 glGetMapdv (i  i  p)v;
 glGetMapfv (i  i  p)v;
 glGetMapiv (i  i  p)v;
 glGetMaterialfv (i  i  p)v;
 glGetMaterialiv (i  i  p)v;
 glGetPixelMapfv (i  p)v;
 glGetPixelMapuiv (i  p)v;
 glGetPixelMapusv (i  p)v;
 glGetPointerv (i  GLvoid*p)v;
 glGetPolygonStipple (p)v;
 glGetString (i )Z;
 glGetTexEnvfv (i  i  p)v;
 glGetTexEnviv (i  i  p)v;
 glGetTexGendv (i  i  p)v;
 glGetTexGenfv (i  i  p)v;
 glGetTexGeniv (i  i  p)v;
 glGetTexImage (i  i  i  i  p)v;
 glGetTexLevelParameterfv (i  i  i  p)v;
 glGetTexLevelParameteriv (i  i  i  p)v;
 glGetTexParameterfv (i  i  p)v;
 glGetTexParameteriv (i  i  p)v;
 glHint (i  i )v;
 glIndexMask (i )v;
 glIndexPointer (i  i   p)v;
 glIndexd (d )v;
 glIndexdv ( p)v;
 glIndexf (f )v;
 glIndexfv ( p)v;
 glIndexi (i )v;
 glIndexiv ( p)v;
 glIndexs (s )v;
 glIndexsv ( p)v;
 glIndexub (c )v;
 glIndexubv ( p)v;
 glInitNames ()v;
 glInterleavedArrays (i  i   p)v;
 glIsEnabled (i )B;
 glIsList (i )B;
 glIsTexture (i )B;
 glLightModelf (i  f )v;
 glLightModelfv (i   p)v;
 glLightModeli (i  i )v;
 glLightModeliv (i   p)v;
 glLightf (i  i  f )v;
 glLightfv (i  i   p)v;
 glLighti (i  i  i )v;
 glLightiv (i  i   p)v;
 glLineStipple (i  s )v;
 glLineWidth (f )v;
 glListBase (i )v;
 glLoadIdentity ()v;
 glLoadMatrixd ( p)v;
 glLoadMatrixf ( p)v;
 glLoadName (i )v;
 glLogicOp (i )v;
 glMap1d (i  d  d  i  i   p)v;
 glMap1f (i  f  f  i  i   p)v;
 glMap2d (i  d  d  i  i  d  d  i  i   p)v;
 glMap2f (i  f  f  i  i  f  f  i  i   p)v;
 glMapGrid1d (i  d  d )v;
 glMapGrid1f (i  f  f )v;
 glMapGrid2d (i  d  d  i  d  d )v;
 glMapGrid2f (i  f  f  i  f v1 f )v;
 glMaterialf (i  i  f )v;
 glMaterialfv (i  i   p)v;
 glMateriali (i  i  i )v;
 glMaterialiv (i  i   p)v;
 glMatrixMode (i )v;
 glMultMatrixd ( p)v;
 glMultMatrixf ( p)v;
 glNewList (i  i )v;
 glNormal3b (c  c  c )v;
 glNormal3bv ( p)v;
 glNormal3d (d  d  d )v;
 glNormal3dv ( p)v;
 glNormal3f (f  f  f )v;
 glNormal3fv ( p)v;
 glNormal3i (i  i  i )v;
 glNormal3iv ( p)v;
 glNormal3s (s  s  s )v;
 glNormal3sv ( p)v;
 glNormalPointer (i  i   p)v;
 glOrtho (d  d  d  d  d  d )v;
 glPassThrough (f )v;
 glPixelMapfv (i  i   p)v;
 glPixelMapuiv (i  i   p)v;
 glPixelMapusv (i  i   p)v;
 glPixelStoref (i  f )v;
 glPixelStorei (i  i )v;
 glPixelTransferf (i  f )v;
 glPixelTransferi (i  i )v;
 glPixelZoom (f  f )v;
 glPointSize (f )v;
 glPolygonMode (i  i )v;
 glPolygonOffset (f  f )v;
 glPolygonStipple ( p)v;
 glPopAttrib ()v;
 glPopClientAttrib ()v;
 glPopMatrix ()v;
 glPopName ()v;
 glPrioritizeTextures (i   p  p)v;
 glPushAttrib(i)v;
 glPushClientAttrib(i)v;
 glPushMatrix()v;
 glPushName(i)v;
 glRasterPos2d(dd)v;
 glRasterPos2dv(p)v;
 glRasterPos2f(ff)v;
 glRasterPos2fv(p)v;
 glRasterPos2i(ii)v;
 glRasterPos2iv(p)v;
 glRasterPos2s(ss)v;
 glRasterPos2sv(p)v;
 glRasterPos3d(ddd)v;
 glRasterPos3dv(p)v;
 glRasterPos3f(fff)v;
 glRasterPos3fv(p)v;
 glRasterPos3i(iii)v;
 glRasterPos3iv(p)v;
 glRasterPos3s(sss)v;
 glRasterPos3sv(p)v;
 glRasterPos4d(dddd)v;
 glRasterPos4dv(p)v;
 glRasterPos4f(ffff)v;
 glRasterPos4fv(p)v;
 glRasterPos4i(iiii)v;
 glRasterPos4iv(p)v;
 glRasterPos4s(ssss)v;
 glRasterPos4sv(p)v;
 glReadBuffer(i)v;
 glReadPixels(iiiiiip)v;
 glRectd(dddd)v;
 glRectdv(pp)v;
 glRectf(ffff)v;
 glRectfv(pp)v;
 glRecti(iiii)v;
 glRectiv(pp)v;
 glRects(ssss)v;
 glRectsv(pp)v;
 glRenderMode(i)i;
 glRotated(dddd)v;
 glRotatef(ffff)v;
 glScaled(ddd)v;
 glScalef(fff)v;
 glScissor(iiii)v;
 glSelectBuffer(ip)v;
 glShadeModel(i)v;
 glStencilFunc(iii)v;
 glStencilMask(i)v;
 glStencilOp(iii)v;
 glTexCoord1d(d)v;
 glTexCoord1dv(p)v;
 glTexCoord1f(f)v;
 glTexCoord1fv(p)v;
 glTexCoord1i(i)v;
 glTexCoord1iv(p)v;
 glTexCoord1s(s)v;
 glTexCoord1sv(p)v;
 glTexCoord2d(dd)v;
 glTexCoord2dv(p)v;
 glTexCoord2f(ff)v;
 glTexCoord2fv(p)v;
 glTexCoord2i(ii)v;
 glTexCoord2iv(p)v;
 glTexCoord2s(ss)v;
 glTexCoord2sv(p)v;
 glTexCoord3d(ddd)v;
 glTexCoord3dv(p)v;
 glTexCoord3f(fff)v;
 glTexCoord3fv(p)v;
 glTexCoord3i(iii)v;
 glTexCoord3iv(p)v;
 glTexCoord3s(sss)v;
 glTexCoord3sv(p)v;
 glTexCoord4d(dddd)v;
 glTexCoord4dv(p)v;
 glTexCoord4f(ffff)v;
 glTexCoord4fv(p)v;
 glTexCoord4i(iiii)v;
 glTexCoord4iv(p)v;
 glTexCoord4s(ssss)v;
 glTexCoord4sv(p)v;
 glTexCoordPointer(iiip)v;
 glTexEnvf(iif)v;
 glTexEnvfv(iip)v;
 glTexEnvi(iii)v;
 glTexEnviv(iip)v;
 glTexGend(iid)v;
 glTexGendv(iip)v;
 glTexGenf(iif)v;
 glTexGenfv(iip)v;
 glTexGeni(iii)v;
 glTexGeniv(iip)v;
 glTexImage1D(i  i  i  i  i  i  i   p)v;
 glTexImage2D(i  i  i  i  i  i  i  i   p)v;
 glTexParameterf (i  i  f )v;
 glTexParameterfv (i  i   p)v;
 glTexParameteri (i  i  i )v;
 glTexParameteriv (i  i   p)v;
 glTexSubImage1D (i  i  i  i  i  i   p)v;
 glTexSubImage2D (i  i  i  i  i  i  i  i   p)v;
 glTranslated (d  d  d )v;
 glTranslatef (f  f  f )v;
 glVertex2d (d  d )v;
 glVertex2dv ( p)v;
 glVertex2f (f  f )v;
 glVertex2fv ( p)v;
 glVertex2i (i  i )v;
 glVertex2iv ( p)v;
 glVertex2s (s  s )v;
 glVertex2sv ( p)v;
 glVertex3d (d  d  d )v;
 glVertex3dv ( p)v;
 glVertex3f (f  f  f )v;
 glVertex3fv ( p)v;
 glVertex3i (i  i  i )v;
 glVertex3iv ( p)v;
 glVertex3s (s  s  s )v;
 glVertex3sv ( p)v;
 glVertex4d (d  d  d  d )v;
 glVertex4dv ( p)v;
 glVertex4f (f  f  f  f )v;
 glVertex4fv ( p)v;
 glVertex4i (i  i  i  i )v;
 glVertex4iv ( p)v;
 glVertex4s (s  s  s  s )v;
 glVertex4sv ( p)v;
 glVertexPointer (i  i  i   p)v;
 glViewport (i  i  i  i )v;

",callmode=.callmode)

# Version */
GL_VERSION_1_1                    = 1

# AttribMask */
GL_CURRENT_BIT                    = 0x00000001
GL_POINT_BIT                      = 0x00000002
GL_LINE_BIT                       = 0x00000004
GL_POLYGON_BIT                    = 0x00000008
GL_POLYGON_STIPPLE_BIT            = 0x00000010
GL_PIXEL_MODE_BIT                 = 0x00000020
GL_LIGHTING_BIT                   = 0x00000040
GL_FOG_BIT                        = 0x00000080
GL_DEPTH_BUFFER_BIT               = 0x00000100
GL_ACCUM_BUFFER_BIT               = 0x00000200
GL_STENCIL_BUFFER_BIT             = 0x00000400
GL_VIEWPORT_BIT                   = 0x00000800
GL_TRANSFORM_BIT                  = 0x00001000
GL_ENABLE_BIT                     = 0x00002000
GL_COLOR_BUFFER_BIT               = 0x00004000
GL_HINT_BIT                       = 0x00008000
GL_EVAL_BIT                       = 0x00010000
GL_LIST_BIT                       = 0x00020000
GL_TEXTURE_BIT                    = 0x00040000
GL_SCISSOR_BIT                    = 0x00080000
GL_ALL_ATTRIB_BITS                = 0xFFFFFFFF

# ClearBufferMask */
#      GL_COLOR_BUFFER_BIT */
#      GL_ACCUM_BUFFER_BIT */
#      GL_STENCIL_BUFFER_BIT */
#      GL_DEPTH_BUFFER_BIT */

# ClientAttribMask */
GL_CLIENT_PIXEL_STORE_BIT         = 0x00000001
GL_CLIENT_VERTEX_ARRAY_BIT        = 0x00000002
GL_CLIENT_ALL_ATTRIB_BITS         = 0xFFFFFFFF

# Boolean */
GL_FALSE                          = 0
GL_TRUE                           = 1

# BeginMode */
GL_POINTS                         = 0x0000
GL_LINES                          = 0x0001
GL_LINE_LOOP                      = 0x0002
GL_LINE_STRIP                     = 0x0003
GL_TRIANGLES                      = 0x0004
GL_TRIANGLE_STRIP                 = 0x0005
GL_TRIANGLE_FAN                   = 0x0006
GL_QUADS                          = 0x0007
GL_QUAD_STRIP                     = 0x0008
GL_POLYGON                        = 0x0009

# AccumOp */
GL_ACCUM                          = 0x0100
GL_LOAD                           = 0x0101
GL_RETURN                         = 0x0102
GL_MULT                           = 0x0103
GL_ADD                            = 0x0104

# AlphaFunction */
GL_NEVER                          = 0x0200
GL_LESS                           = 0x0201
GL_EQUAL                          = 0x0202
GL_LEQUAL                         = 0x0203
GL_GREATER                        = 0x0204
GL_NOTEQUAL                       = 0x0205
GL_GEQUAL                         = 0x0206
GL_ALWAYS                         = 0x0207

# BlendingFactorDest */
GL_ZERO                           = 0
GL_ONE                            = 1
GL_SRC_COLOR                      = 0x0300
GL_ONE_MINUS_SRC_COLOR            = 0x0301
GL_SRC_ALPHA                      = 0x0302
GL_ONE_MINUS_SRC_ALPHA            = 0x0303
GL_DST_ALPHA                      = 0x0304
GL_ONE_MINUS_DST_ALPHA            = 0x0305

# BlendingFactorSrc */
#      GL_ZERO */
#      GL_ONE */
GL_DST_COLOR                      = 0x0306
GL_ONE_MINUS_DST_COLOR            = 0x0307
GL_SRC_ALPHA_SATURATE             = 0x0308
#      GL_SRC_ALPHA */
#      GL_ONE_MINUS_SRC_ALPHA */
#      GL_DST_ALPHA */
#      GL_ONE_MINUS_DST_ALPHA */

# ColorMaterialFace */
#      GL_FRONT */
#      GL_BACK */
#      GL_FRONT_AND_BACK */

# ColorMaterialParameter */
#      GL_AMBIENT */
#      GL_DIFFUSE */
#      GL_SPECULAR */
#      GL_EMISSION */
#      GL_AMBIENT_AND_DIFFUSE */

# ColorPointerType */
#      GL_BYTE */
#      GL_UNSIGNED_BYTE */
#      GL_SHORT */
#      GL_UNSIGNED_SHORT */
#      GL_INT */
#      GL_UNSIGNED_INT */
#      GL_FLOAT */
#      GL_DOUBLE */

# CullFaceMode */
#      GL_FRONT */
#      GL_BACK */
#      GL_FRONT_AND_BACK */

# DepthFunction */
#      GL_NEVER */
#      GL_LESS */
#      GL_EQUAL */
#      GL_LEQUAL */
#      GL_GREATER */
#      GL_NOTEQUAL */
#      GL_GEQUAL */
#      GL_ALWAYS */

# DrawBufferMode */
GL_NONE                           = 0
GL_FRONT_LEFT                     = 0x0400
GL_FRONT_RIGHT                    = 0x0401
GL_BACK_LEFT                      = 0x0402
GL_BACK_RIGHT                     = 0x0403
GL_FRONT                          = 0x0404
GL_BACK                           = 0x0405
GL_LEFT                           = 0x0406
GL_RIGHT                          = 0x0407
GL_FRONT_AND_BACK                 = 0x0408
GL_AUX0                           = 0x0409
GL_AUX1                           = 0x040A
GL_AUX2                           = 0x040B
GL_AUX3                           = 0x040C

# EnableCap */
#      GL_FOG */
#      GL_LIGHTING */
#      GL_TEXTURE_1D */
#      GL_TEXTURE_2D */
#      GL_LINE_STIPPLE */
#      GL_POLYGON_STIPPLE */
#      GL_CULL_FACE */
#      GL_ALPHA_TEST */
#      GL_BLEND */
#      GL_INDEX_LOGIC_OP */
#      GL_COLOR_LOGIC_OP */
#      GL_DITHER */
#      GL_STENCIL_TEST */
#      GL_DEPTH_TEST */
#      GL_CLIP_PLANE0 */
#      GL_CLIP_PLANE1 */
#      GL_CLIP_PLANE2 */
#      GL_CLIP_PLANE3 */
#      GL_CLIP_PLANE4 */
#      GL_CLIP_PLANE5 */
#      GL_LIGHT0 */
#      GL_LIGHT1 */
#      GL_LIGHT2 */
#      GL_LIGHT3 */
#      GL_LIGHT4 */
#      GL_LIGHT5 */
#      GL_LIGHT6 */
#      GL_LIGHT7 */
#      GL_TEXTURE_GEN_S */
#      GL_TEXTURE_GEN_T */
#      GL_TEXTURE_GEN_R */
#      GL_TEXTURE_GEN_Q */
#      GL_MAP1_VERTEX_3 */
#      GL_MAP1_VERTEX_4 */
#      GL_MAP1_COLOR_4 */
#      GL_MAP1_INDEX */
#      GL_MAP1_NORMAL */
#      GL_MAP1_TEXTURE_COORD_1 */
#      GL_MAP1_TEXTURE_COORD_2 */
#      GL_MAP1_TEXTURE_COORD_3 */
#      GL_MAP1_TEXTURE_COORD_4 */
#      GL_MAP2_VERTEX_3 */
#      GL_MAP2_VERTEX_4 */
#      GL_MAP2_COLOR_4 */
#      GL_MAP2_INDEX */
#      GL_MAP2_NORMAL */
#      GL_MAP2_TEXTURE_COORD_1 */
#      GL_MAP2_TEXTURE_COORD_2 */
#      GL_MAP2_TEXTURE_COORD_3 */
#      GL_MAP2_TEXTURE_COORD_4 */
#      GL_POINT_SMOOTH */
#      GL_LINE_SMOOTH */
#      GL_POLYGON_SMOOTH */
#      GL_SCISSOR_TEST */
#      GL_COLOR_MATERIAL */
#      GL_NORMALIZE */
#      GL_AUTO_NORMAL */
#      GL_POLYGON_OFFSET_POINT */
#      GL_POLYGON_OFFSET_LINE */
#      GL_POLYGON_OFFSET_FILL */
#      GL_VERTEX_ARRAY */
#      GL_NORMAL_ARRAY */
#      GL_COLOR_ARRAY */
#      GL_INDEX_ARRAY */
#      GL_TEXTURE_COORD_ARRAY */
#      GL_EDGE_FLAG_ARRAY */

# ErrorCode */
GL_NO_ERROR                       = 0
GL_INVALID_ENUM                   = 0x0500
GL_INVALID_VALUE                  = 0x0501
GL_INVALID_OPERATION              = 0x0502
GL_STACK_OVERFLOW                 = 0x0503
GL_STACK_UNDERFLOW                = 0x0504
GL_OUT_OF_MEMORY                  = 0x0505
GL_TABLE_TOO_LARGE                = 0x8031

# FeedbackType */
GL_2D                             = 0x0600
GL_3D                             = 0x0601
GL_3D_COLOR                       = 0x0602
GL_3D_COLOR_TEXTURE               = 0x0603
GL_4D_COLOR_TEXTURE               = 0x0604

# FeedBackToken */
GL_PASS_THROUGH_TOKEN             = 0x0700
GL_POINT_TOKEN                    = 0x0701
GL_LINE_TOKEN                     = 0x0702
GL_POLYGON_TOKEN                  = 0x0703
GL_BITMAP_TOKEN                   = 0x0704
GL_DRAW_PIXEL_TOKEN               = 0x0705
GL_COPY_PIXEL_TOKEN               = 0x0706
GL_LINE_RESET_TOKEN               = 0x0707

# FogMode */
#      GL_LINEAR */
GL_EXP                            = 0x0800
GL_EXP2                           = 0x0801

# FogParameter */
#      GL_FOG_COLOR */
#      GL_FOG_DENSITY */
#      GL_FOG_END */
#      GL_FOG_INDEX */
#      GL_FOG_MODE */
#      GL_FOG_START */

# FrontFaceDirection */
GL_CW                             = 0x0900
GL_CCW                            = 0x0901

# GetMapQuery */
GL_COEFF                          = 0x0A00
GL_ORDER                          = 0x0A01
GL_DOMAIN                         = 0x0A02

# GetPixelMap */
GL_PIXEL_MAP_I_TO_I               = 0x0C70
GL_PIXEL_MAP_S_TO_S               = 0x0C71
GL_PIXEL_MAP_I_TO_R               = 0x0C72
GL_PIXEL_MAP_I_TO_G               = 0x0C73
GL_PIXEL_MAP_I_TO_B               = 0x0C74
GL_PIXEL_MAP_I_TO_A               = 0x0C75
GL_PIXEL_MAP_R_TO_R               = 0x0C76
GL_PIXEL_MAP_G_TO_G               = 0x0C77
GL_PIXEL_MAP_B_TO_B               = 0x0C78
GL_PIXEL_MAP_A_TO_A               = 0x0C79

# GetPointervPName */
GL_VERTEX_ARRAY_POINTER           = 0x808E
GL_NORMAL_ARRAY_POINTER           = 0x808F
GL_COLOR_ARRAY_POINTER            = 0x8090
GL_INDEX_ARRAY_POINTER            = 0x8091
GL_TEXTURE_COORD_ARRAY_POINTER    = 0x8092
GL_EDGE_FLAG_ARRAY_POINTER        = 0x8093

# GetPName */
GL_CURRENT_COLOR                  = 0x0B00
GL_CURRENT_INDEX                  = 0x0B01
GL_CURRENT_NORMAL                 = 0x0B02
GL_CURRENT_TEXTURE_COORDS         = 0x0B03
GL_CURRENT_RASTER_COLOR           = 0x0B04
GL_CURRENT_RASTER_INDEX           = 0x0B05
GL_CURRENT_RASTER_TEXTURE_COORDS  = 0x0B06
GL_CURRENT_RASTER_POSITION        = 0x0B07
GL_CURRENT_RASTER_POSITION_VALID  = 0x0B08
GL_CURRENT_RASTER_DISTANCE        = 0x0B09
GL_POINT_SMOOTH                   = 0x0B10
GL_POINT_SIZE                     = 0x0B11
GL_SMOOTH_POINT_SIZE_RANGE        = 0x0B12
GL_SMOOTH_POINT_SIZE_GRANULARITY  = 0x0B13
GL_POINT_SIZE_RANGE               = GL_SMOOTH_POINT_SIZE_RANGE
GL_POINT_SIZE_GRANULARITY         = GL_SMOOTH_POINT_SIZE_GRANULARITY
GL_LINE_SMOOTH                    = 0x0B20
GL_LINE_WIDTH                     = 0x0B21
GL_SMOOTH_LINE_WIDTH_RANGE        = 0x0B22
GL_SMOOTH_LINE_WIDTH_GRANULARITY  = 0x0B23
GL_LINE_WIDTH_RANGE               = GL_SMOOTH_LINE_WIDTH_RANGE
GL_LINE_WIDTH_GRANULARITY         = GL_SMOOTH_LINE_WIDTH_GRANULARITY
GL_LINE_STIPPLE                   = 0x0B24
GL_LINE_STIPPLE_PATTERN           = 0x0B25
GL_LINE_STIPPLE_REPEAT            = 0x0B26
GL_LIST_MODE                      = 0x0B30
GL_MAX_LIST_NESTING               = 0x0B31
GL_LIST_BASE                      = 0x0B32
GL_LIST_INDEX                     = 0x0B33
GL_POLYGON_MODE                   = 0x0B40
GL_POLYGON_SMOOTH                 = 0x0B41
GL_POLYGON_STIPPLE                = 0x0B42
GL_EDGE_FLAG                      = 0x0B43
GL_CULL_FACE                      = 0x0B44
GL_CULL_FACE_MODE                 = 0x0B45
GL_FRONT_FACE                     = 0x0B46
GL_LIGHTING                       = 0x0B50
GL_LIGHT_MODEL_LOCAL_VIEWER       = 0x0B51
GL_LIGHT_MODEL_TWO_SIDE           = 0x0B52
GL_LIGHT_MODEL_AMBIENT            = 0x0B53
GL_SHADE_MODEL                    = 0x0B54
GL_COLOR_MATERIAL_FACE            = 0x0B55
GL_COLOR_MATERIAL_PARAMETER       = 0x0B56
GL_COLOR_MATERIAL                 = 0x0B57
GL_FOG                            = 0x0B60
GL_FOG_INDEX                      = 0x0B61
GL_FOG_DENSITY                    = 0x0B62
GL_FOG_START                      = 0x0B63
GL_FOG_END                        = 0x0B64
GL_FOG_MODE                       = 0x0B65
GL_FOG_COLOR                      = 0x0B66
GL_DEPTH_RANGE                    = 0x0B70
GL_DEPTH_TEST                     = 0x0B71
GL_DEPTH_WRITEMASK                = 0x0B72
GL_DEPTH_CLEAR_VALUE              = 0x0B73
GL_DEPTH_FUNC                     = 0x0B74
GL_ACCUM_CLEAR_VALUE              = 0x0B80
GL_STENCIL_TEST                   = 0x0B90
GL_STENCIL_CLEAR_VALUE            = 0x0B91
GL_STENCIL_FUNC                   = 0x0B92
GL_STENCIL_VALUE_MASK             = 0x0B93
GL_STENCIL_FAIL                   = 0x0B94
GL_STENCIL_PASS_DEPTH_FAIL        = 0x0B95
GL_STENCIL_PASS_DEPTH_PASS        = 0x0B96
GL_STENCIL_REF                    = 0x0B97
GL_STENCIL_WRITEMASK              = 0x0B98
GL_MATRIX_MODE                    = 0x0BA0
GL_NORMALIZE                      = 0x0BA1
GL_VIEWPORT                       = 0x0BA2
GL_MODELVIEW_STACK_DEPTH          = 0x0BA3
GL_PROJECTION_STACK_DEPTH         = 0x0BA4
GL_TEXTURE_STACK_DEPTH            = 0x0BA5
GL_MODELVIEW_MATRIX               = 0x0BA6
GL_PROJECTION_MATRIX              = 0x0BA7
GL_TEXTURE_MATRIX                 = 0x0BA8
GL_ATTRIB_STACK_DEPTH             = 0x0BB0
GL_CLIENT_ATTRIB_STACK_DEPTH      = 0x0BB1
GL_ALPHA_TEST                     = 0x0BC0
GL_ALPHA_TEST_FUNC                = 0x0BC1
GL_ALPHA_TEST_REF                 = 0x0BC2
GL_DITHER                         = 0x0BD0
GL_BLEND_DST                      = 0x0BE0
GL_BLEND_SRC                      = 0x0BE1
GL_BLEND                          = 0x0BE2
GL_LOGIC_OP_MODE                  = 0x0BF0
GL_INDEX_LOGIC_OP                 = 0x0BF1
GL_LOGIC_OP                       = GL_INDEX_LOGIC_OP
GL_COLOR_LOGIC_OP                 = 0x0BF2
GL_AUX_BUFFERS                    = 0x0C00
GL_DRAW_BUFFER                    = 0x0C01
GL_READ_BUFFER                    = 0x0C02
GL_SCISSOR_BOX                    = 0x0C10
GL_SCISSOR_TEST                   = 0x0C11
GL_INDEX_CLEAR_VALUE              = 0x0C20
GL_INDEX_WRITEMASK                = 0x0C21
GL_COLOR_CLEAR_VALUE              = 0x0C22
GL_COLOR_WRITEMASK                = 0x0C23
GL_INDEX_MODE                     = 0x0C30
GL_RGBA_MODE                      = 0x0C31
GL_DOUBLEBUFFER                   = 0x0C32
GL_STEREO                         = 0x0C33
GL_RENDER_MODE                    = 0x0C40
GL_PERSPECTIVE_CORRECTION_HINT    = 0x0C50
GL_POINT_SMOOTH_HINT              = 0x0C51
GL_LINE_SMOOTH_HINT               = 0x0C52
GL_POLYGON_SMOOTH_HINT            = 0x0C53
GL_FOG_HINT                       = 0x0C54
GL_TEXTURE_GEN_S                  = 0x0C60
GL_TEXTURE_GEN_T                  = 0x0C61
GL_TEXTURE_GEN_R                  = 0x0C62
GL_TEXTURE_GEN_Q                  = 0x0C63
GL_PIXEL_MAP_I_TO_I_SIZE          = 0x0CB0
GL_PIXEL_MAP_S_TO_S_SIZE          = 0x0CB1
GL_PIXEL_MAP_I_TO_R_SIZE          = 0x0CB2
GL_PIXEL_MAP_I_TO_G_SIZE          = 0x0CB3
GL_PIXEL_MAP_I_TO_B_SIZE          = 0x0CB4
GL_PIXEL_MAP_I_TO_A_SIZE          = 0x0CB5
GL_PIXEL_MAP_R_TO_R_SIZE          = 0x0CB6
GL_PIXEL_MAP_G_TO_G_SIZE          = 0x0CB7
GL_PIXEL_MAP_B_TO_B_SIZE          = 0x0CB8
GL_PIXEL_MAP_A_TO_A_SIZE          = 0x0CB9
GL_UNPACK_SWAP_BYTES              = 0x0CF0
GL_UNPACK_LSB_FIRST               = 0x0CF1
GL_UNPACK_ROW_LENGTH              = 0x0CF2
GL_UNPACK_SKIP_ROWS               = 0x0CF3
GL_UNPACK_SKIP_PIXELS             = 0x0CF4
GL_UNPACK_ALIGNMENT               = 0x0CF5
GL_PACK_SWAP_BYTES                = 0x0D00
GL_PACK_LSB_FIRST                 = 0x0D01
GL_PACK_ROW_LENGTH                = 0x0D02
GL_PACK_SKIP_ROWS                 = 0x0D03
GL_PACK_SKIP_PIXELS               = 0x0D04
GL_PACK_ALIGNMENT                 = 0x0D05
GL_MAP_COLOR                      = 0x0D10
GL_MAP_STENCIL                    = 0x0D11
GL_INDEX_SHIFT                    = 0x0D12
GL_INDEX_OFFSET                   = 0x0D13
GL_RED_SCALE                      = 0x0D14
GL_RED_BIAS                       = 0x0D15
GL_ZOOM_X                         = 0x0D16
GL_ZOOM_Y                         = 0x0D17
GL_GREEN_SCALE                    = 0x0D18
GL_GREEN_BIAS                     = 0x0D19
GL_BLUE_SCALE                     = 0x0D1A
GL_BLUE_BIAS                      = 0x0D1B
GL_ALPHA_SCALE                    = 0x0D1C
GL_ALPHA_BIAS                     = 0x0D1D
GL_DEPTH_SCALE                    = 0x0D1E
GL_DEPTH_BIAS                     = 0x0D1F
GL_MAX_EVAL_ORDER                 = 0x0D30
GL_MAX_LIGHTS                     = 0x0D31
GL_MAX_CLIP_PLANES                = 0x0D32
GL_MAX_TEXTURE_SIZE               = 0x0D33
GL_MAX_PIXEL_MAP_TABLE            = 0x0D34
GL_MAX_ATTRIB_STACK_DEPTH         = 0x0D35
GL_MAX_MODELVIEW_STACK_DEPTH      = 0x0D36
GL_MAX_NAME_STACK_DEPTH           = 0x0D37
GL_MAX_PROJECTION_STACK_DEPTH     = 0x0D38
GL_MAX_TEXTURE_STACK_DEPTH        = 0x0D39
GL_MAX_VIEWPORT_DIMS              = 0x0D3A
GL_MAX_CLIENT_ATTRIB_STACK_DEPTH  = 0x0D3B
GL_SUBPIXEL_BITS                  = 0x0D50
GL_INDEX_BITS                     = 0x0D51
GL_RED_BITS                       = 0x0D52
GL_GREEN_BITS                     = 0x0D53
GL_BLUE_BITS                      = 0x0D54
GL_ALPHA_BITS                     = 0x0D55
GL_DEPTH_BITS                     = 0x0D56
GL_STENCIL_BITS                   = 0x0D57
GL_ACCUM_RED_BITS                 = 0x0D58
GL_ACCUM_GREEN_BITS               = 0x0D59
GL_ACCUM_BLUE_BITS                = 0x0D5A
GL_ACCUM_ALPHA_BITS               = 0x0D5B
GL_NAME_STACK_DEPTH               = 0x0D70
GL_AUTO_NORMAL                    = 0x0D80
GL_MAP1_COLOR_4                   = 0x0D90
GL_MAP1_INDEX                     = 0x0D91
GL_MAP1_NORMAL                    = 0x0D92
GL_MAP1_TEXTURE_COORD_1           = 0x0D93
GL_MAP1_TEXTURE_COORD_2           = 0x0D94
GL_MAP1_TEXTURE_COORD_3           = 0x0D95
GL_MAP1_TEXTURE_COORD_4           = 0x0D96
GL_MAP1_VERTEX_3                  = 0x0D97
GL_MAP1_VERTEX_4                  = 0x0D98
GL_MAP2_COLOR_4                   = 0x0DB0
GL_MAP2_INDEX                     = 0x0DB1
GL_MAP2_NORMAL                    = 0x0DB2
GL_MAP2_TEXTURE_COORD_1           = 0x0DB3
GL_MAP2_TEXTURE_COORD_2           = 0x0DB4
GL_MAP2_TEXTURE_COORD_3           = 0x0DB5
GL_MAP2_TEXTURE_COORD_4           = 0x0DB6
GL_MAP2_VERTEX_3                  = 0x0DB7
GL_MAP2_VERTEX_4                  = 0x0DB8
GL_MAP1_GRID_DOMAIN               = 0x0DD0
GL_MAP1_GRID_SEGMENTS             = 0x0DD1
GL_MAP2_GRID_DOMAIN               = 0x0DD2
GL_MAP2_GRID_SEGMENTS             = 0x0DD3
GL_TEXTURE_1D                     = 0x0DE0
GL_TEXTURE_2D                     = 0x0DE1
GL_FEEDBACK_BUFFER_POINTER        = 0x0DF0
GL_FEEDBACK_BUFFER_SIZE           = 0x0DF1
GL_FEEDBACK_BUFFER_TYPE           = 0x0DF2
GL_SELECTION_BUFFER_POINTER       = 0x0DF3
GL_SELECTION_BUFFER_SIZE          = 0x0DF4
GL_POLYGON_OFFSET_UNITS           = 0x2A00
GL_POLYGON_OFFSET_POINT           = 0x2A01
GL_POLYGON_OFFSET_LINE            = 0x2A02
GL_POLYGON_OFFSET_FILL            = 0x8037
GL_POLYGON_OFFSET_FACTOR          = 0x8038
GL_TEXTURE_BINDING_1D             = 0x8068
GL_TEXTURE_BINDING_2D             = 0x8069
GL_TEXTURE_BINDING_3D             = 0x806A
GL_VERTEX_ARRAY                   = 0x8074
GL_NORMAL_ARRAY                   = 0x8075
GL_COLOR_ARRAY                    = 0x8076
GL_INDEX_ARRAY                    = 0x8077
GL_TEXTURE_COORD_ARRAY            = 0x8078
GL_EDGE_FLAG_ARRAY                = 0x8079
GL_VERTEX_ARRAY_SIZE              = 0x807A
GL_VERTEX_ARRAY_TYPE              = 0x807B
GL_VERTEX_ARRAY_STRIDE            = 0x807C
GL_NORMAL_ARRAY_TYPE              = 0x807E
GL_NORMAL_ARRAY_STRIDE            = 0x807F
GL_COLOR_ARRAY_SIZE               = 0x8081
GL_COLOR_ARRAY_TYPE               = 0x8082
GL_COLOR_ARRAY_STRIDE             = 0x8083
GL_INDEX_ARRAY_TYPE               = 0x8085
GL_INDEX_ARRAY_STRIDE             = 0x8086
GL_TEXTURE_COORD_ARRAY_SIZE       = 0x8088
GL_TEXTURE_COORD_ARRAY_TYPE       = 0x8089
GL_TEXTURE_COORD_ARRAY_STRIDE     = 0x808A
GL_EDGE_FLAG_ARRAY_STRIDE         = 0x808C
#      GL_VERTEX_ARRAY_COUNT_EXT */
#      GL_NORMAL_ARRAY_COUNT_EXT */
#      GL_COLOR_ARRAY_COUNT_EXT */
#      GL_INDEX_ARRAY_COUNT_EXT */
#      GL_TEXTURE_COORD_ARRAY_COUNT_EXT */
#      GL_EDGE_FLAG_ARRAY_COUNT_EXT */

# GetTextureParameter */
#      GL_TEXTURE_MAG_FILTER */
#      GL_TEXTURE_MIN_FILTER */
#      GL_TEXTURE_WRAP_S */
#      GL_TEXTURE_WRAP_T */
GL_TEXTURE_WIDTH                  = 0x1000
GL_TEXTURE_HEIGHT                 = 0x1001
GL_TEXTURE_INTERNAL_FORMAT        = 0x1003
GL_TEXTURE_COMPONENTS             = GL_TEXTURE_INTERNAL_FORMAT
GL_TEXTURE_BORDER_COLOR           = 0x1004
GL_TEXTURE_BORDER                 = 0x1005
GL_TEXTURE_RED_SIZE               = 0x805C
GL_TEXTURE_GREEN_SIZE             = 0x805D
GL_TEXTURE_BLUE_SIZE              = 0x805E
GL_TEXTURE_ALPHA_SIZE             = 0x805F
GL_TEXTURE_LUMINANCE_SIZE         = 0x8060
GL_TEXTURE_INTENSITY_SIZE         = 0x8061
GL_TEXTURE_PRIORITY               = 0x8066
GL_TEXTURE_RESIDENT               = 0x8067

# HintMode */
GL_DONT_CARE                      = 0x1100
GL_FASTEST                        = 0x1101
GL_NICEST                         = 0x1102

# HintTarget */
#      GL_PERSPECTIVE_CORRECTION_HINT */
#      GL_POINT_SMOOTH_HINT */
#      GL_LINE_SMOOTH_HINT */
#      GL_POLYGON_SMOOTH_HINT */
#      GL_FOG_HINT */

# IndexMaterialParameterSGI */
#      GL_INDEX_OFFSET */

# IndexPointerType */
#      GL_SHORT */
#      GL_INT */
#      GL_FLOAT */
#      GL_DOUBLE */

# IndexFunctionSGI */
#      GL_NEVER */
#      GL_LESS */
#      GL_EQUAL */
#      GL_LEQUAL */
#      GL_GREATER */
#      GL_NOTEQUAL */
#      GL_GEQUAL */
#      GL_ALWAYS */

# LightModelParameter */
#      GL_LIGHT_MODEL_AMBIENT */
#      GL_LIGHT_MODEL_LOCAL_VIEWER */
#      GL_LIGHT_MODEL_TWO_SIDE */

# LightParameter */
GL_AMBIENT                        = 0x1200
GL_DIFFUSE                        = 0x1201
GL_SPECULAR                       = 0x1202
GL_POSITION                       = 0x1203
GL_SPOT_DIRECTION                 = 0x1204
GL_SPOT_EXPONENT                  = 0x1205
GL_SPOT_CUTOFF                    = 0x1206
GL_CONSTANT_ATTENUATION           = 0x1207
GL_LINEAR_ATTENUATION             = 0x1208
GL_QUADRATIC_ATTENUATION          = 0x1209

# ListMode */
GL_COMPILE                        = 0x1300
GL_COMPILE_AND_EXECUTE            = 0x1301

# DataType */
GL_BYTE                           = 0x1400
GL_UNSIGNED_BYTE                  = 0x1401
GL_SHORT                          = 0x1402
GL_UNSIGNED_SHORT                 = 0x1403
GL_INT                            = 0x1404
GL_UNSIGNED_INT                   = 0x1405
GL_FLOAT                          = 0x1406
GL_2_BYTES                        = 0x1407
GL_3_BYTES                        = 0x1408
GL_4_BYTES                        = 0x1409
GL_DOUBLE                         = 0x140A
GL_DOUBLE_EXT                     = 0x140A

# ListNameType */
#      GL_BYTE */
#      GL_UNSIGNED_BYTE */
#      GL_SHORT */
#      GL_UNSIGNED_SHORT */
#      GL_INT */
#      GL_UNSIGNED_INT */
#      GL_FLOAT */
#      GL_2_BYTES */
#      GL_3_BYTES */
#      GL_4_BYTES */

# LogicOp */
GL_CLEAR                          = 0x1500
GL_AND                            = 0x1501
GL_AND_REVERSE                    = 0x1502
GL_COPY                           = 0x1503
GL_AND_INVERTED                   = 0x1504
GL_NOOP                           = 0x1505
GL_XOR                            = 0x1506
GL_OR                             = 0x1507
GL_NOR                            = 0x1508
GL_EQUIV                          = 0x1509
GL_INVERT                         = 0x150A
GL_OR_REVERSE                     = 0x150B
GL_COPY_INVERTED                  = 0x150C
GL_OR_INVERTED                    = 0x150D
GL_NAND                           = 0x150E
GL_SET                            = 0x150F

# MapTarget */
#      GL_MAP1_COLOR_4 */
#      GL_MAP1_INDEX */
#      GL_MAP1_NORMAL */
#      GL_MAP1_TEXTURE_COORD_1 */
#      GL_MAP1_TEXTURE_COORD_2 */
#      GL_MAP1_TEXTURE_COORD_3 */
#      GL_MAP1_TEXTURE_COORD_4 */
#      GL_MAP1_VERTEX_3 */
#      GL_MAP1_VERTEX_4 */
#      GL_MAP2_COLOR_4 */
#      GL_MAP2_INDEX */
#      GL_MAP2_NORMAL */
#      GL_MAP2_TEXTURE_COORD_1 */
#      GL_MAP2_TEXTURE_COORD_2 */
#      GL_MAP2_TEXTURE_COORD_3 */
#      GL_MAP2_TEXTURE_COORD_4 */
#      GL_MAP2_VERTEX_3 */
#      GL_MAP2_VERTEX_4 */

# MaterialFace */
#      GL_FRONT */
#      GL_BACK */
#      GL_FRONT_AND_BACK */

# MaterialParameter */
GL_EMISSION                       = 0x1600
GL_SHININESS                      = 0x1601
GL_AMBIENT_AND_DIFFUSE            = 0x1602
GL_COLOR_INDEXES                  = 0x1603
#      GL_AMBIENT */
#      GL_DIFFUSE */
#      GL_SPECULAR */

# MatrixMode */
GL_MODELVIEW                      = 0x1700
GL_PROJECTION                     = 0x1701
GL_TEXTURE                        = 0x1702

# MeshMode1 */
#      GL_POINT */
#      GL_LINE */

# MeshMode2 */
#      GL_POINT */
#      GL_LINE */
#      GL_FILL */

# NormalPointerType */
#      GL_BYTE */
#      GL_SHORT */
#      GL_INT */
#      GL_FLOAT */
#      GL_DOUBLE */

# PixelCopyType */
GL_COLOR                          = 0x1800
GL_DEPTH                          = 0x1801
GL_STENCIL                        = 0x1802

# PixelFormat */
GL_COLOR_INDEX                    = 0x1900
GL_STENCIL_INDEX                  = 0x1901
GL_DEPTH_COMPONENT                = 0x1902
GL_RED                            = 0x1903
GL_GREEN                          = 0x1904
GL_BLUE                           = 0x1905
GL_ALPHA                          = 0x1906
GL_RGB                            = 0x1907
GL_RGBA                           = 0x1908
GL_LUMINANCE                      = 0x1909
GL_LUMINANCE_ALPHA                = 0x190A
#      GL_ABGR_EXT */

# PixelMap */
#      GL_PIXEL_MAP_I_TO_I */
#      GL_PIXEL_MAP_S_TO_S */
#      GL_PIXEL_MAP_I_TO_R */
#      GL_PIXEL_MAP_I_TO_G */
#      GL_PIXEL_MAP_I_TO_B */
#      GL_PIXEL_MAP_I_TO_A */
#      GL_PIXEL_MAP_R_TO_R */
#      GL_PIXEL_MAP_G_TO_G */
#      GL_PIXEL_MAP_B_TO_B */
#      GL_PIXEL_MAP_A_TO_A */

# PixelStoreParameter */
#      GL_UNPACK_SWAP_BYTES */
#      GL_UNPACK_LSB_FIRST */
#      GL_UNPACK_ROW_LENGTH */
#      GL_UNPACK_SKIP_ROWS */
#      GL_UNPACK_SKIP_PIXELS */
#      GL_UNPACK_ALIGNMENT */
#      GL_PACK_SWAP_BYTES */
#      GL_PACK_LSB_FIRST */
#      GL_PACK_ROW_LENGTH */
#      GL_PACK_SKIP_ROWS */
#      GL_PACK_SKIP_PIXELS */
#      GL_PACK_ALIGNMENT */

# PixelTransferParameter */
#      GL_MAP_COLOR */
#      GL_MAP_STENCIL */
#      GL_INDEX_SHIFT */
#      GL_INDEX_OFFSET */
#      GL_RED_SCALE */
#      GL_RED_BIAS */
#      GL_GREEN_SCALE */
#      GL_GREEN_BIAS */
#      GL_BLUE_SCALE */
#      GL_BLUE_BIAS */
#      GL_ALPHA_SCALE */
#      GL_ALPHA_BIAS */
#      GL_DEPTH_SCALE */
#      GL_DEPTH_BIAS */

# PixelType */
GL_BITMAP                         = 0x1A00
#      GL_BYTE */
#      GL_UNSIGNED_BYTE */
#      GL_SHORT */
#      GL_UNSIGNED_SHORT */
#      GL_INT */
#      GL_UNSIGNED_INT */
#      GL_FLOAT */
#      GL_UNSIGNED_BYTE_3_3_2_EXT */
#      GL_UNSIGNED_SHORT_4_4_4_4_EXT */
#      GL_UNSIGNED_SHORT_5_5_5_1_EXT */
#      GL_UNSIGNED_INT_8_8_8_8_EXT */
#      GL_UNSIGNED_INT_10_10_10_2_EXT */

# PolygonMode */
GL_POINT                          = 0x1B00
GL_LINE                           = 0x1B01
GL_FILL                           = 0x1B02

# ReadBufferMode */
#      GL_FRONT_LEFT */
#      GL_FRONT_RIGHT */
#      GL_BACK_LEFT */
#      GL_BACK_RIGHT */
#      GL_FRONT */
#      GL_BACK */
#      GL_LEFT */
#      GL_RIGHT */
#      GL_AUX0 */
#      GL_AUX1 */
#      GL_AUX2 */
#      GL_AUX3 */

# RenderingMode */
GL_RENDER                         = 0x1C00
GL_FEEDBACK                       = 0x1C01
GL_SELECT                         = 0x1C02

# ShadingModel */
GL_FLAT                           = 0x1D00
GL_SMOOTH                         = 0x1D01

# StencilFunction */
#      GL_NEVER */
#      GL_LESS */
#      GL_EQUAL */
#      GL_LEQUAL */
#      GL_GREATER */
#      GL_NOTEQUAL */
#      GL_GEQUAL */
#      GL_ALWAYS */

# StencilOp */
#      GL_ZERO */
GL_KEEP                           = 0x1E00
GL_REPLACE                        = 0x1E01
GL_INCR                           = 0x1E02
GL_DECR                           = 0x1E03
#      GL_INVERT */

# StringName */
GL_VENDOR                         = 0x1F00
GL_RENDERER                       = 0x1F01
GL_VERSION                        = 0x1F02
GL_EXTENSIONS                     = 0x1F03

# TexCoordPointerType */
#      GL_SHORT */
#      GL_INT */
#      GL_FLOAT */
#      GL_DOUBLE */

# TextureCoordName */
GL_S                              = 0x2000
GL_T                              = 0x2001
GL_R                              = 0x2002
GL_Q                              = 0x2003

# TextureEnvMode */
GL_MODULATE                       = 0x2100
GL_DECAL                          = 0x2101
#      GL_BLEND */
#      GL_REPLACE */
#      GL_ADD */

# TextureEnvParameter */
GL_TEXTURE_ENV_MODE               = 0x2200
GL_TEXTURE_ENV_COLOR              = 0x2201

# TextureEnvTarget */
GL_TEXTURE_ENV                    = 0x2300

# TextureGenMode */
GL_EYE_LINEAR                     = 0x2400
GL_OBJECT_LINEAR                  = 0x2401
GL_SPHERE_MAP                     = 0x2402

# TextureGenParameter */
GL_TEXTURE_GEN_MODE               = 0x2500
GL_OBJECT_PLANE                   = 0x2501
GL_EYE_PLANE                      = 0x2502

# TextureMagFilter */
GL_NEAREST                        = 0x2600
GL_LINEAR                         = 0x2601

# TextureMinFilter */
#      GL_NEAREST */
#      GL_LINEAR */
GL_NEAREST_MIPMAP_NEAREST         = 0x2700
GL_LINEAR_MIPMAP_NEAREST          = 0x2701
GL_NEAREST_MIPMAP_LINEAR          = 0x2702
GL_LINEAR_MIPMAP_LINEAR           = 0x2703

# TextureParameterName */
GL_TEXTURE_MAG_FILTER             = 0x2800
GL_TEXTURE_MIN_FILTER             = 0x2801
GL_TEXTURE_WRAP_S                 = 0x2802
GL_TEXTURE_WRAP_T                 = 0x2803
#      GL_TEXTURE_BORDER_COLOR */
#      GL_TEXTURE_PRIORITY */

# TextureTarget */
#      GL_TEXTURE_1D */
#      GL_TEXTURE_2D */
GL_PROXY_TEXTURE_1D               = 0x8063
GL_PROXY_TEXTURE_2D               = 0x8064

# TextureWrapMode */
GL_CLAMP                          = 0x2900
GL_REPEAT                         = 0x2901

# PixelInternalFormat */
GL_R3_G3_B2                       = 0x2A10
GL_ALPHA4                         = 0x803B
GL_ALPHA8                         = 0x803C
GL_ALPHA12                        = 0x803D
GL_ALPHA16                        = 0x803E
GL_LUMINANCE4                     = 0x803F
GL_LUMINANCE8                     = 0x8040
GL_LUMINANCE12                    = 0x8041
GL_LUMINANCE16                    = 0x8042
GL_LUMINANCE4_ALPHA4              = 0x8043
GL_LUMINANCE6_ALPHA2              = 0x8044
GL_LUMINANCE8_ALPHA8              = 0x8045
GL_LUMINANCE12_ALPHA4             = 0x8046
GL_LUMINANCE12_ALPHA12            = 0x8047
GL_LUMINANCE16_ALPHA16            = 0x8048
GL_INTENSITY                      = 0x8049
GL_INTENSITY4                     = 0x804A
GL_INTENSITY8                     = 0x804B
GL_INTENSITY12                    = 0x804C
GL_INTENSITY16                    = 0x804D
GL_RGB4                           = 0x804F
GL_RGB5                           = 0x8050
GL_RGB8                           = 0x8051
GL_RGB10                          = 0x8052
GL_RGB12                          = 0x8053
GL_RGB16                          = 0x8054
GL_RGBA2                          = 0x8055
GL_RGBA4                          = 0x8056
GL_RGB5_A1                        = 0x8057
GL_RGBA8                          = 0x8058
GL_RGB10_A2                       = 0x8059
GL_RGBA12                         = 0x805A
GL_RGBA16                         = 0x805B

# InterleavedArrayFormat */
GL_V2F                            = 0x2A20
GL_V3F                            = 0x2A21
GL_C4UB_V2F                       = 0x2A22
GL_C4UB_V3F                       = 0x2A23
GL_C3F_V3F                        = 0x2A24
GL_N3F_V3F                        = 0x2A25
GL_C4F_N3F_V3F                    = 0x2A26
GL_T2F_V3F                        = 0x2A27
GL_T4F_V4F                        = 0x2A28
GL_T2F_C4UB_V3F                   = 0x2A29
GL_T2F_C3F_V3F                    = 0x2A2A
GL_T2F_N3F_V3F                    = 0x2A2B
GL_T2F_C4F_N3F_V3F                = 0x2A2C
GL_T4F_C4F_N3F_V4F                = 0x2A2D

# VertexPointerType */
#      GL_SHORT */
#      GL_INT */
#      GL_FLOAT */
#      GL_DOUBLE */

# ClipPlaneName */
GL_CLIP_PLANE0                    = 0x3000
GL_CLIP_PLANE1                    = 0x3001
GL_CLIP_PLANE2                    = 0x3002
GL_CLIP_PLANE3                    = 0x3003
GL_CLIP_PLANE4                    = 0x3004
GL_CLIP_PLANE5                    = 0x3005

# LightName */
GL_LIGHT0                         = 0x4000
GL_LIGHT1                         = 0x4001
GL_LIGHT2                         = 0x4002
GL_LIGHT3                         = 0x4003
GL_LIGHT4                         = 0x4004
GL_LIGHT5                         = 0x4005
GL_LIGHT6                         = 0x4006
GL_LIGHT7                         = 0x4007

# EXT_abgr */
GL_ABGR_EXT                       = 0x8000

# EXT_blend_subtract */
GL_FUNC_SUBTRACT_EXT              = 0x800A
GL_FUNC_REVERSE_SUBTRACT_EXT      = 0x800B

# EXT_packed_pixels */
GL_UNSIGNED_BYTE_3_3_2_EXT        = 0x8032
GL_UNSIGNED_SHORT_4_4_4_4_EXT     = 0x8033
GL_UNSIGNED_SHORT_5_5_5_1_EXT     = 0x8034
GL_UNSIGNED_INT_8_8_8_8_EXT       = 0x8035
GL_UNSIGNED_INT_10_10_10_2_EXT    = 0x8036

# OpenGL12 */
GL_PACK_SKIP_IMAGES               = 0x806B
GL_PACK_IMAGE_HEIGHT              = 0x806C
GL_UNPACK_SKIP_IMAGES             = 0x806D
GL_UNPACK_IMAGE_HEIGHT            = 0x806E
GL_TEXTURE_3D                     = 0x806F
GL_PROXY_TEXTURE_3D               = 0x8070
GL_TEXTURE_DEPTH                  = 0x8071
GL_TEXTURE_WRAP_R                 = 0x8072
GL_MAX_3D_TEXTURE_SIZE            = 0x8073
GL_BGR                            = 0x80E0
GL_BGRA                           = 0x80E1
GL_UNSIGNED_BYTE_3_3_2            = 0x8032
GL_UNSIGNED_BYTE_2_3_3_REV        = 0x8362
GL_UNSIGNED_SHORT_5_6_5           = 0x8363
GL_UNSIGNED_SHORT_5_6_5_REV       = 0x8364
GL_UNSIGNED_SHORT_4_4_4_4         = 0x8033
GL_UNSIGNED_SHORT_4_4_4_4_REV     = 0x8365
GL_UNSIGNED_SHORT_5_5_5_1         = 0x8034
GL_UNSIGNED_SHORT_1_5_5_5_REV     = 0x8366
GL_UNSIGNED_INT_8_8_8_8           = 0x8035
GL_UNSIGNED_INT_8_8_8_8_REV       = 0x8367
GL_UNSIGNED_INT_10_10_10_2        = 0x8036
GL_UNSIGNED_INT_2_10_10_10_REV    = 0x8368
GL_RESCALE_NORMAL                 = 0x803A
GL_LIGHT_MODEL_COLOR_CONTROL      = 0x81F8
GL_SINGLE_COLOR                   = 0x81F9
GL_SEPARATE_SPECULAR_COLOR        = 0x81FA
GL_CLAMP_TO_EDGE                  = 0x812F
GL_TEXTURE_MIN_LOD                = 0x813A
GL_TEXTURE_MAX_LOD                = 0x813B
GL_TEXTURE_BASE_LEVEL             = 0x813C
GL_TEXTURE_MAX_LEVEL              = 0x813D
GL_MAX_ELEMENTS_VERTICES          = 0x80E8
GL_MAX_ELEMENTS_INDICES           = 0x80E9
GL_ALIASED_POINT_SIZE_RANGE       = 0x846D
GL_ALIASED_LINE_WIDTH_RANGE       = 0x846E

# OpenGL13 */
GL_ACTIVE_TEXTURE                 = 0x84E0
GL_CLIENT_ACTIVE_TEXTURE          = 0x84E1
GL_MAX_TEXTURE_UNITS              = 0x84E2
GL_TEXTURE0                       = 0x84C0
GL_TEXTURE1                       = 0x84C1
GL_TEXTURE2                       = 0x84C2
GL_TEXTURE3                       = 0x84C3
GL_TEXTURE4                       = 0x84C4
GL_TEXTURE5                       = 0x84C5
GL_TEXTURE6                       = 0x84C6
GL_TEXTURE7                       = 0x84C7
GL_TEXTURE8                       = 0x84C8
GL_TEXTURE9                       = 0x84C9
GL_TEXTURE10                      = 0x84CA
GL_TEXTURE11                      = 0x84CB
GL_TEXTURE12                      = 0x84CC
GL_TEXTURE13                      = 0x84CD
GL_TEXTURE14                      = 0x84CE
GL_TEXTURE15                      = 0x84CF
GL_TEXTURE16                      = 0x84D0
GL_TEXTURE17                      = 0x84D1
GL_TEXTURE18                      = 0x84D2
GL_TEXTURE19                      = 0x84D3
GL_TEXTURE20                      = 0x84D4
GL_TEXTURE21                      = 0x84D5
GL_TEXTURE22                      = 0x84D6
GL_TEXTURE23                      = 0x84D7
GL_TEXTURE24                      = 0x84D8
GL_TEXTURE25                      = 0x84D9
GL_TEXTURE26                      = 0x84DA
GL_TEXTURE27                      = 0x84DB
GL_TEXTURE28                      = 0x84DC
GL_TEXTURE29                      = 0x84DD
GL_TEXTURE30                      = 0x84DE
GL_TEXTURE31                      = 0x84DF
GL_NORMAL_MAP                     = 0x8511
GL_REFLECTION_MAP                 = 0x8512
GL_TEXTURE_CUBE_MAP               = 0x8513
GL_TEXTURE_BINDING_CUBE_MAP       = 0x8514
GL_TEXTURE_CUBE_MAP_POSITIVE_X    = 0x8515
GL_TEXTURE_CUBE_MAP_NEGATIVE_X    = 0x8516
GL_TEXTURE_CUBE_MAP_POSITIVE_Y    = 0x8517
GL_TEXTURE_CUBE_MAP_NEGATIVE_Y    = 0x8518
GL_TEXTURE_CUBE_MAP_POSITIVE_Z    = 0x8519
GL_TEXTURE_CUBE_MAP_NEGATIVE_Z    = 0x851A
GL_PROXY_TEXTURE_CUBE_MAP         = 0x851B
GL_MAX_CUBE_MAP_TEXTURE_SIZE      = 0x851C
GL_COMBINE                        = 0x8570
GL_COMBINE_RGB                    = 0x8571
GL_COMBINE_ALPHA                  = 0x8572
GL_RGB_SCALE                      = 0x8573
GL_ADD_SIGNED                     = 0x8574
GL_INTERPOLATE                    = 0x8575
GL_CONSTANT                       = 0x8576
GL_PRIMARY_COLOR                  = 0x8577
GL_PREVIOUS                       = 0x8578
GL_SOURCE0_RGB                    = 0x8580
GL_SOURCE1_RGB                    = 0x8581
GL_SOURCE2_RGB                    = 0x8582
GL_SOURCE0_ALPHA                  = 0x8588
GL_SOURCE1_ALPHA                  = 0x8589
GL_SOURCE2_ALPHA                  = 0x858A
GL_OPERAND0_RGB                   = 0x8590
GL_OPERAND1_RGB                   = 0x8591
GL_OPERAND2_RGB                   = 0x8592
GL_OPERAND0_ALPHA                 = 0x8598
GL_OPERAND1_ALPHA                 = 0x8599
GL_OPERAND2_ALPHA                 = 0x859A
GL_SUBTRACT                       = 0x84E7
GL_TRANSPOSE_MODELVIEW_MATRIX     = 0x84E3
GL_TRANSPOSE_PROJECTION_MATRIX    = 0x84E4
GL_TRANSPOSE_TEXTURE_MATRIX       = 0x84E5
GL_TRANSPOSE_COLOR_MATRIX         = 0x84E6
GL_COMPRESSED_ALPHA               = 0x84E9
GL_COMPRESSED_LUMINANCE           = 0x84EA
GL_COMPRESSED_LUMINANCE_ALPHA     = 0x84EB
GL_COMPRESSED_INTENSITY           = 0x84EC
GL_COMPRESSED_RGB                 = 0x84ED
GL_COMPRESSED_RGBA                = 0x84EE
GL_TEXTURE_COMPRESSION_HINT       = 0x84EF
GL_TEXTURE_COMPRESSED_IMAGE_SIZE  = 0x86A0
GL_TEXTURE_COMPRESSED             = 0x86A1
GL_NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2
GL_COMPRESSED_TEXTURE_FORMATS     = 0x86A3
GL_DOT3_RGB                       = 0x86AE
GL_DOT3_RGBA                      = 0x86AF
GL_CLAMP_TO_BORDER                = 0x812D
GL_MULTISAMPLE                    = 0x809D
GL_SAMPLE_ALPHA_TO_COVERAGE       = 0x809E
GL_SAMPLE_ALPHA_TO_ONE            = 0x809F
GL_SAMPLE_COVERAGE                = 0x80A0
GL_SAMPLE_BUFFERS                 = 0x80A8
GL_SAMPLES                        = 0x80A9
GL_SAMPLE_COVERAGE_VALUE          = 0x80AA
GL_SAMPLE_COVERAGE_INVERT         = 0x80AB
GL_MULTISAMPLE_BIT                = 0x20000000

# EXT_vertex_array */
GL_VERTEX_ARRAY_EXT               = 0x8074
GL_NORMAL_ARRAY_EXT               = 0x8075
GL_COLOR_ARRAY_EXT                = 0x8076
GL_INDEX_ARRAY_EXT                = 0x8077
GL_TEXTURE_COORD_ARRAY_EXT        = 0x8078
GL_EDGE_FLAG_ARRAY_EXT            = 0x8079
GL_VERTEX_ARRAY_SIZE_EXT          = 0x807A
GL_VERTEX_ARRAY_TYPE_EXT          = 0x807B
GL_VERTEX_ARRAY_STRIDE_EXT        = 0x807C
GL_VERTEX_ARRAY_COUNT_EXT         = 0x807D
GL_NORMAL_ARRAY_TYPE_EXT          = 0x807E
GL_NORMAL_ARRAY_STRIDE_EXT        = 0x807F
GL_NORMAL_ARRAY_COUNT_EXT         = 0x8080
GL_COLOR_ARRAY_SIZE_EXT           = 0x8081
GL_COLOR_ARRAY_TYPE_EXT           = 0x8082
GL_COLOR_ARRAY_STRIDE_EXT         = 0x8083
GL_COLOR_ARRAY_COUNT_EXT          = 0x8084
GL_INDEX_ARRAY_TYPE_EXT           = 0x8085
GL_INDEX_ARRAY_STRIDE_EXT         = 0x8086
GL_INDEX_ARRAY_COUNT_EXT          = 0x8087
GL_TEXTURE_COORD_ARRAY_SIZE_EXT   = 0x8088
GL_TEXTURE_COORD_ARRAY_TYPE_EXT   = 0x8089
GL_TEXTURE_COORD_ARRAY_STRIDE_EXT = 0x808A
GL_TEXTURE_COORD_ARRAY_COUNT_EXT  = 0x808B
GL_EDGE_FLAG_ARRAY_STRIDE_EXT     = 0x808C
GL_EDGE_FLAG_ARRAY_COUNT_EXT      = 0x808D
GL_VERTEX_ARRAY_POINTER_EXT       = 0x808E
GL_NORMAL_ARRAY_POINTER_EXT       = 0x808F
GL_COLOR_ARRAY_POINTER_EXT        = 0x8090
GL_INDEX_ARRAY_POINTER_EXT        = 0x8091
GL_TEXTURE_COORD_ARRAY_POINTER_EXT = 0x8092
GL_EDGE_FLAG_ARRAY_POINTER_EXT    = 0x8093

# SGIS_texture_lod */
GL_TEXTURE_MIN_LOD_SGIS           = 0x813A
GL_TEXTURE_MAX_LOD_SGIS           = 0x813B
GL_TEXTURE_BASE_LEVEL_SGIS        = 0x813C
GL_TEXTURE_MAX_LEVEL_SGIS         = 0x813D

# EXT_shared_texture_palette */
GL_SHARED_TEXTURE_PALETTE_EXT     = 0x81FB

# EXT_rescale_normal */
GL_RESCALE_NORMAL_EXT             = 0x803A

# SGIX_shadow */
GL_TEXTURE_COMPARE_SGIX           = 0x819A
GL_TEXTURE_COMPARE_OPERATOR_SGIX  = 0x819B
GL_TEXTURE_LEQUAL_R_SGIX          = 0x819C
GL_TEXTURE_GEQUAL_R_SGIX          = 0x819D

# SGIX_depth_texture */
GL_DEPTH_COMPONENT16_SGIX         = 0x81A5
GL_DEPTH_COMPONENT24_SGIX         = 0x81A6
GL_DEPTH_COMPONENT32_SGIX         = 0x81A7

# SGIS_generate_mipmap */
GL_GENERATE_MIPMAP_SGIS           = 0x8191
GL_GENERATE_MIPMAP_HINT_SGIS      = 0x8192

# OpenGL14 */
GL_POINT_SIZE_MIN                 = 0x8126
GL_POINT_SIZE_MAX                 = 0x8127
GL_POINT_FADE_THRESHOLD_SIZE      = 0x8128
GL_POINT_DISTANCE_ATTENUATION     = 0x8129
GL_FOG_COORDINATE_SOURCE          = 0x8450
GL_FOG_COORDINATE                 = 0x8451
GL_FRAGMENT_DEPTH                 = 0x8452
GL_CURRENT_FOG_COORDINATE         = 0x8453
GL_FOG_COORDINATE_ARRAY_TYPE      = 0x8454
GL_FOG_COORDINATE_ARRAY_STRIDE    = 0x8455
GL_FOG_COORDINATE_ARRAY_POINTER   = 0x8456
GL_FOG_COORDINATE_ARRAY           = 0x8457
GL_COLOR_SUM                      = 0x8458
GL_CURRENT_SECONDARY_COLOR        = 0x8459
GL_SECONDARY_COLOR_ARRAY_SIZE     = 0x845A
GL_SECONDARY_COLOR_ARRAY_TYPE     = 0x845B
GL_SECONDARY_COLOR_ARRAY_STRIDE   = 0x845C
GL_SECONDARY_COLOR_ARRAY_POINTER  = 0x845D
GL_SECONDARY_COLOR_ARRAY          = 0x845E
GL_INCR_WRAP                      = 0x8507
GL_DECR_WRAP                      = 0x8508
GL_MAX_TEXTURE_LOD_BIAS           = 0x84FD
GL_TEXTURE_FILTER_CONTROL         = 0x8500
GL_TEXTURE_LOD_BIAS               = 0x8501
GL_GENERATE_MIPMAP                = 0x8191
GL_GENERATE_MIPMAP_HINT           = 0x8192
GL_BLEND_DST_RGB                  = 0x80C8
GL_BLEND_SRC_RGB                  = 0x80C9
GL_BLEND_DST_ALPHA                = 0x80CA
GL_BLEND_SRC_ALPHA                = 0x80CB
GL_MIRRORED_REPEAT                = 0x8370
GL_DEPTH_COMPONENT16              = 0x81A5
GL_DEPTH_COMPONENT24              = 0x81A6
GL_DEPTH_COMPONENT32              = 0x81A7
GL_TEXTURE_DEPTH_SIZE             = 0x884A
GL_DEPTH_TEXTURE_MODE             = 0x884B
GL_TEXTURE_COMPARE_MODE           = 0x884C
GL_TEXTURE_COMPARE_FUNC           = 0x884D
GL_COMPARE_R_TO_TEXTURE           = 0x884E


# extensions:

commented <- function() {

if (.Platform$OS == "windows") {
  dynbind(libname,"wglGetProcAddress(S)p;")
  dynbind.gl <- function(libsignature,envir=parent.frame(),callmode="stdcall")
  {
    # eat white spaces
    sigtab <- gsub("[ \n\t]*","",libsignature)
  
    # split functions at ';'
    sigtab <- strsplit(sigtab, ";")[[1]]
  
    # split name/call signature at '('
    sigtab <- strsplit(sigtab, "\\(")
    
    dyncallfunc <- as.symbol( paste(".dyncall.",callmode, sep="") )
    
    # install functions
    for (i in seq(along=sigtab)) 
    {
      symname   <- sigtab[[i]][[1]]
      signature <- sigtab[[i]][[2]]
      address  <- wglGetProcAddress( symname )
      if (!is.null(address))
      {
        f <- function(...) NULL
        body(f) <- substitute( dyncallfunc(address, signature,...), list(dyncallfunc=dyncallfunc,address=address,signature=signature) )
        environment(f) <- envir # NEW
        assign( symname, f, envir=envir)  
      }
      else
      {
        warning("unable to find symbol ", symname, " in shared library ", libname)
      }
    }
  }
  # dynbind.gl("glGenBuffers()")
}
}
