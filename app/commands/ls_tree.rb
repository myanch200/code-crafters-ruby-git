module Commands
  def self.ls_tree(sub_command, hash)
    case sub_command
    when '--name-only'
      name_only(hash)
    else
      puts "Unknown option: #{sub_command}"
    end
  end

  def self.name_only(hash)
    path = ".git/objects/#{hash[0..1]}/#{hash[2..-1]}"
    data = Zlib::Inflate.inflate(File.read(path))
    entries = []
    pos = 0

    while pos < data.length
      # Skip "tree" prefix if it exists
      pos += 5 if data[pos..pos + 3] == 'tree'

      # Find the space after mode
      space_pos = data.index(' ', pos)
      break unless space_pos

      # Find the null byte after the name
      null_pos = data.index("\0", space_pos)
      break unless null_pos

      # Extract just the name (between space and null byte)
      name = data[(space_pos + 1)...null_pos]
      entries << name

      # Move past the SHA (20 bytes after null byte)
      pos = null_pos + 21
    end

    puts entries.join("\n")
  end
end
