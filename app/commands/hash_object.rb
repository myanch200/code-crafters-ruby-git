# frozen_string_literal: true

require 'digest'

# Commands module
module Commands
  def self.hash_object(sub_command, file_path)
    case sub_command
    when '-w'
      write_object(file_path)
    else
      puts "Unknown sub-command: #{sub_command}"
    end
  end

  def self.write_object(file_path)
    content = File.read(file_path)
    blob = "blob #{content.bytesize}\0#{content}"
    sha = Digest::SHA1.hexdigest(blob)
    dir = ".git/objects/#{sha[0..1]}"
    Dir.mkdir(dir) unless Dir.exist?(dir)
    File.open(".git/objects/#{sha[0..1]}/#{sha[2..]}", 'wb') do |f|
      f.write(Zlib::Deflate.deflate(blob))
    end
    print sha
    $stdout.flush
  end
end
