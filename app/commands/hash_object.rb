require 'digest'

module Commands
  def self.hash_object(sub_command, file_path)
    case sub_command
    when "-w"
      write_object(file_path)
    else
      puts "Unknown sub-command: #{sub_command}"
    end
  end

  def self.write_object(file_path)
    content = File.read(file_path)
    blob = "blob #{content.bytesize}\0#{content}"
    sha = Digest::SHA1.hexdigest(blob)
    File.write(".git/objects/#{sha[0..1]}/#{sha[2..-1]}", Zlib::Deflate.deflate(blob))
  end
end