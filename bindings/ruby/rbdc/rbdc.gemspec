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

	spec.version               = '0.1.0'
#	spec.platform              = Gem::Platform::Win32
	spec.required_ruby_version = '>= 1.9.1'

	spec.files                 = FileList['dyncall/**/*', 'bindings/ruby/rbdc/rbdc.c'].to_a
	spec.extensions            << 'bindings/ruby/rbdc/extconf.rb'
end
