require 'rubygems'; require 'term/ansicolor'

include Term::ANSIColor

aliases = ARGV[0].split("\n").grep /^alias/
last_cmd = ARGV[1].split("\n").first[/\s+\d+\s+(.*)/, 1]

matching = aliases.select { |al|
  al.include? last_cmd
  cmd = (al[/.*='(.*)'$/, 1] || al[/.*="(.*)"$/, 1])
  (cmd) && (last_cmd[0, cmd.length] == cmd)
}

exit if matching.empty?

puts ""
puts red("*** Become more pro! Could've used these aliases: ")
matching.each do |m|
  puts green(m)
end
