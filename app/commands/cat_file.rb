require "zlib"

module Commands
  def self.cat_file(sub_command, hash)
    case sub_command
    when "-p"
      pretty_print(hash)
    else
      puts "Unknown sub-command: #{sub_command}"
    end
  end

  def self.pretty_print(file_path)
    file_path = ".git/objects/#{file_path[0..1]}/#{file_path[2..-1]}"
    puts file_path
    if File.exist?(file_path)
      # remove the initial signiture of blob 11\0
      content = Zlib::Inflate.inflate(File.read(file_path)).sub(/^blob \d+\0/, "")
      puts content
    else
      puts "File not found: #{file_path}"
    end
  end
end