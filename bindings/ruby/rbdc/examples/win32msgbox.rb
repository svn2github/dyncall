#//////////////////////////////////////////////////////////////////////
#
#	win32msgbox.rb
#	Copyright 2007 Tassilo Philipp
#
#	Dyncall sample loading user32.dll on windows and displaying a
#	native windows message box by calling MessageBoxA(...).
#
#///////////////////////////////////////////////////////////////////////

require 'rbdc'

l = Dyncall::ExtLib.new
if l.load('user32') != nil
	l.each { |s| puts s }
	puts l.symbol_count
	puts l.exists?(:NonExistant)
	puts l.exists?(:MessageBoxA)
	puts l.call(:MessageBoxA, 'ippi)v', 0, 'Hello world from dyncall!', 'dyncall demo', 0)
end
