# frozen_string_literal: true

require_relative "commands/init"
require_relative "commands/cat_file"
require_relative "commands/hash_object"
require_relative "commands/ls_tree"

# Uncomment this block to pass the first stage
#
command = ARGV[0]
case command
when "init"
  Commands.init
when "cat-file"
  Commands.cat_file(ARGV[1], ARGV[2])
when "hash-object"
  Commands.hash_object(ARGV[1], ARGV[2])
when "ls-tree"
  Commands.ls_tree(ARGV[1], ARGV[2])
else
  raise RuntimeError.new("Unknown command #{command}")
end
