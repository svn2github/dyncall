#//////////////////////////////////////////////////////////////////////
#
#	extconf.rb
#	Copyright 2007 Tassilo Philipp
#
#	Configuration file for dyncall/ruby extension. This script creates
#	a makefile that can be used to compile the C-extension. It is
#	configured such that every .c file in this directory will be used
#	for compilation.
#
#///////////////////////////////////////////////////////////////////////

require 'mkmf'

#un = `uname -a`
#if un.include?("i386") or un.include?("i686") then
#  $CFLAGS = "#($CFLAGS) -Dbla"
#else
#  $CFLAGS = "#($CFLAGS)"
#end
#have_header "stdint.h" 
$LOCAL_LIBS = 'dyncall/libdyncall_s.lib dynload/libdynload_s.lib'


dir_config "rbdc"

# Write out a makefile for our dyncall extension.
create_makefile "rbdc"
#create_header "config.h" 
