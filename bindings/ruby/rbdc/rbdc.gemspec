#//////////////////////////////////////////////////////////////////////
#
# rbdc.gemspec
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
# Ruby gems specification file.
#
#///////////////////////////////////////////////////////////////////////

require 'rake'
base_dir = '../../..'
Dir.chdir(base_dir)

Gem::Specification.new do |spec|
	spec.name                  = 'rbdc'
	spec.author                = 'Tassilo Philipp'
	spec.email                 = 'tphilipp@potion-studios.com'
	spec.homepage              = 'http://www.dyncall.org'

	spec.summary               = 'C call invoker for ruby.'
	spec.description           = 'rbdc is a ruby binding to the dyncall and dynload C libraries, allowing programmers to call C functions from ruby without writing any glue code at all.'

	spec.version               = '0.8.2'
	spec.required_ruby_version = '>= 1.9.1'

	spec.files                 = FileList['dyncall/**/*', 'bindings/ruby/rbdc/rbdc.c'].exclude('dyncall/doc/**/*').exclude('dyncall/test/**/*').to_a
	spec.extensions            << 'bindings/ruby/rbdc/extconf.rb'
end
