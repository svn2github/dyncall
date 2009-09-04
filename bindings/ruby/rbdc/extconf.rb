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

dir_config 'rbdc'

lib_dirs = []# "../../../dyncall/dyncall", "../../../dyncall/dynload" ]
base_dir = '../../../dyncall/'
Dir[base_dir+'**/*'].each { |d|
  $LOCAL_LIBS << '"'+d+'" ' if d =~ /(lib)?dyn(call|load)_s\./
}


if($LOCAL_LIBS.size > 0) then
	# Write out a makefile for our dyncall extension.
	create_makefile 'rbdc'
else
	puts "Couldn't find dyncall and dynload libraries - make sure to build them first!"
end
