/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class org_dyncall_DC */

#ifndef _Included_org_dyncall_DC
#define _Included_org_dyncall_DC
#ifdef __cplusplus
extern "C" {
#endif
#undef org_dyncall_DC_DEFAULT_C
#define org_dyncall_DC_DEFAULT_C 0L
#undef org_dyncall_DC_X86_WIN32_FAST
#define org_dyncall_DC_X86_WIN32_FAST 1L
#undef org_dyncall_DC_X86_WIN32_STD
#define org_dyncall_DC_X86_WIN32_STD 2L
#undef org_dyncall_DC_X86_WIN32_THIS_MS
#define org_dyncall_DC_X86_WIN32_THIS_MS 3L
/*
 * Class:     org_dyncall_DC
 * Method:    newCallVM
 * Signature: (II)J
 */
JNIEXPORT jlong JNICALL Java_org_dyncall_DC_newCallVM
  (JNIEnv *, jclass, jint, jint);

/*
 * Class:     org_dyncall_DC
 * Method:    reset
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_reset
  (JNIEnv *, jclass, jlong);

/*
 * Class:     org_dyncall_DC
 * Method:    argBool
 * Signature: (JZ)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argBool
  (JNIEnv *, jclass, jlong, jboolean);

/*
 * Class:     org_dyncall_DC
 * Method:    argByte
 * Signature: (JB)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argByte
  (JNIEnv *, jclass, jlong, jbyte);

/*
 * Class:     org_dyncall_DC
 * Method:    argShort
 * Signature: (JS)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argShort
  (JNIEnv *, jclass, jlong, jshort);

/*
 * Class:     org_dyncall_DC
 * Method:    argInt
 * Signature: (JI)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argInt
  (JNIEnv *, jclass, jlong, jint);

/*
 * Class:     org_dyncall_DC
 * Method:    argLong
 * Signature: (JJ)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argLong
  (JNIEnv *, jclass, jlong, jlong);

/*
 * Class:     org_dyncall_DC
 * Method:    argChar
 * Signature: (JC)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argChar
  (JNIEnv *, jclass, jlong, jchar);

/*
 * Class:     org_dyncall_DC
 * Method:    argFloat
 * Signature: (JF)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argFloat
  (JNIEnv *, jclass, jlong, jfloat);

/*
 * Class:     org_dyncall_DC
 * Method:    argDouble
 * Signature: (JD)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argDouble
  (JNIEnv *, jclass, jlong, jdouble);

/*
 * Class:     org_dyncall_DC
 * Method:    argPointer
 * Signature: (JJ)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argPointer__JJ
  (JNIEnv *, jclass, jlong, jlong);

/*
 * Class:     org_dyncall_DC
 * Method:    argPointer
 * Signature: (JLjava/lang/Object;)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argPointer__JLjava_lang_Object_2
  (JNIEnv *, jclass, jlong, jobject);

/*
 * Class:     org_dyncall_DC
 * Method:    argString
 * Signature: (JLjava/lang/String;)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_argString
  (JNIEnv *, jclass, jlong, jstring);

/*
 * Class:     org_dyncall_DC
 * Method:    callVoid
 * Signature: (JJ)V
 */
JNIEXPORT void JNICALL Java_org_dyncall_DC_callVoid
  (JNIEnv *, jclass, jlong, jlong);

/*
 * Class:     org_dyncall_DC
 * Method:    callBoolean
 * Signature: (JJ)Z
 */
JNIEXPORT jboolean JNICALL Java_org_dyncall_DC_callBoolean
  (JNIEnv *, jclass, jlong, jlong);

/*
 * Class:     org_dyncall_DC
 * Method:    callInt
 * Signature: (JJ)I
 */
JNIEXPORT jint JNICALL Java_org_dyncall_DC_callInt
  (JNIEnv *, jclass, jlong, jlong);

/*
 * Class:     org_dyncall_DC
 * Method:    callLong
 * Signature: (JJ)J
 */
JNIEXPORT jlong JNICALL Java_org_dyncall_DC_callLong
  (JNIEnv *, jclass, jlong, jlong);

#ifdef __cplusplus
}
#endif
#endif
