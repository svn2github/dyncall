#//////////////////////////////////////////////////////////////////////
#
# extconf.rb
# Copyright (c) 2007-2009 Daniel Adler <dadler@uni-goettingen.de>, 
#                         Tassilo Philipp <tphilipp@potion-studios.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# Configuration file for dyncall/ruby extension. This script creates
# a makefile that can be used to compile the C-extension. It is
# configured such that every .c file in this directory will be used
# for compilation.
#
#///////////////////////////////////////////////////////////////////////

require 'mkmf'

dir_config 'rbdc'
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
