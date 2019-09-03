IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = File.join(ENV["HOME"], ".irb-history")

require 'irb/completion' rescue nil

begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError
  puts 'No awesome_print :('
end
