# dynport file for R

if (.Platform$OS == "windows") {
  libname <- "opengl32"
} else {
  libname <- "gl"
}

dynbind(libname,"
glGetError()i;
glClearColor(ffff)v;
glClear(i)v;
glMatrixMode(i)v;
glLoadIdentity()v;
glBegin(i)v;
glEnd()v;
glVertex3d(ddd)v;
glRotated(dddd)v;
glGenLists(i)i;
glNewList(ii)v;
glEnableClientState(i)v;
glVertexPointer(iiip)v;
glColorPointer(iiip)v;
glDrawElements(iiip)v;
glDisableClientState(i)v;
glEndList()v;
glCallList(i)v;
",callmode="stdcall")

GL_FALSE                                = 0x0L
GL_TRUE                                 = 0x1L

GL_BYTE                           =      0x1400L
GL_UNSIGNED_BYTE                  =      0x1401L
GL_SHORT                          =      0x1402L
GL_UNSIGNED_SHORT                 =      0x1403L
GL_INT                            =      0x1404L
GL_UNSIGNED_INT                   =      0x1405L
GL_FLOAT                          =      0x1406L
GL_DOUBLE                         =      0x140AL
GL_2_BYTES                        =      0x1407L
GL_3_BYTES                        =      0x1408L
GL_4_BYTES                        =      0x1409L


GL_COMPILE                        =     0x1300L
GL_COMPILE_AND_EXECUTE            =     0x1301L
GL_LIST_BASE                      =     0x0B32L
GL_LIST_INDEX                     =     0x0B33L
GL_LIST_MODE                      =     0x0B30L

GL_VERTEX_ARRAY                    =     0x8074L
 GL_NORMAL_ARRAY                   =      0x8075L
 GL_COLOR_ARRAY                    =      0x8076L
 GL_INDEX_ARRAY                    =      0x8077L
 GL_TEXTURE_COORD_ARRAY            =      0x8078L
 GL_EDGE_FLAG_ARRAY                =      0x8079L
 GL_VERTEX_ARRAY_SIZE              =      0x807AL
 GL_VERTEX_ARRAY_TYPE              =      0x807BL
 GL_VERTEX_ARRAY_STRIDE            =      0x807CL
 GL_NORMAL_ARRAY_TYPE              =      0x807EL
 GL_NORMAL_ARRAY_STRIDE            =      0x807FL
 GL_COLOR_ARRAY_SIZE               =      0x8081L
 GL_COLOR_ARRAY_TYPE               =      0x8082L
 GL_COLOR_ARRAY_STRIDE             =      0x8083L
 GL_INDEX_ARRAY_TYPE               =      0x8085L
 GL_INDEX_ARRAY_STRIDE             =      0x8086L
 GL_TEXTURE_COORD_ARRAY_SIZE       =      0x8088L
 GL_TEXTURE_COORD_ARRAY_TYPE       =      0x8089L
 GL_TEXTURE_COORD_ARRAY_STRIDE     =      0x808AL
 GL_EDGE_FLAG_ARRAY_STRIDE         =      0x808CL
 GL_VERTEX_ARRAY_POINTER           =      0x808EL
 GL_NORMAL_ARRAY_POINTER           =      0x808FL
 GL_COLOR_ARRAY_POINTER            =      0x8090L
 GL_INDEX_ARRAY_POINTER            =      0x8091L
 GL_TEXTURE_COORD_ARRAY_POINTER    =      0x8092L
 GL_EDGE_FLAG_ARRAY_POINTER        =      0x8093L
 GL_V2F                            =      0x2A20L
 GL_V3F                            =      0x2A21L
 GL_C4UB_V2F                       =      0x2A22L
 GL_C4UB_V3F                       =      0x2A23L
 GL_C3F_V3F                        =      0x2A24L
 GL_N3F_V3F                        =      0x2A25L
 GL_C4F_N3F_V3F                     =     0x2A26L
 GL_T2F_V3F                        =      0x2A27L
 GL_T4F_V4F                        =      0x2A28L
 GL_T2F_C4UB_V3F                   =      0x2A29L
 GL_T2F_C3F_V3F                    =      0x2A2AL
 GL_T2F_N3F_V3F                    =      0x2A2BL
 GL_T2F_C4F_N3F_V3F                =      0x2A2CL
 GL_T4F_C4F_N3F_V4F                =      0x2A2DL


GL_COLOR_BUFFER_BIT = 0x00004000L

GL_MODELVIEW = 0x1700L
GL_PROJECTION =  0x1701L
GL_TEXTURE = 0x1702L

GL_POINTS                         = 0x0000L
GL_LINES                          = 0x0001L
GL_LINE_LOOP                      = 0x0002L
GL_LINE_STRIP                     = 0x0003L
GL_TRIANGLES                      = 0x0004L
GL_TRIANGLE_STRIP                 = 0x0005L
GL_TRIANGLE_FAN                   = 0x0006L
GL_QUADS                          = 0x0007L
GL_QUAD_STRIP                     = 0x0008L
GL_POLYGON                        = 0x0009L
