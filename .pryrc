
Pry.config.color = true
Pry.config.editor = "emacs"

require 'awesome_print'
require 'hirb'

# hirb
Hirb.enable
old_print = Pry.config.print
Pry.config.print = proc do |*args|
  Hirb::View.view_or_page_output(args[1]) || old_print.call(*args)
end

# if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
# end

# See http://qiita.com/ae06710/items/d8367c9c6a0745f05d91
#  pry 0.10.0にてundefined method `pager`が起きたときの暫定対処
# Pry.config.pager = false

