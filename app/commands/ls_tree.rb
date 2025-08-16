# frozen_string_literal: true

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
    path = ".git/objects/#{hash[0..1]}/#{hash[2..]}"
    data = Zlib::Inflate.inflate(File.read(path))
    entries = []

    populate_entries(data, entries)

    puts entries.join("\n")
  end

  def self.populate_entries(data, entries)
    pos = 0

    while pos < data.length
      pos += 5 if data[pos..pos + 3] == 'tree'
      space_pos = data.index(' ', pos)
      break unless space_pos

      null_pos = data.index("\0", space_pos)
      break unless null_pos

      name = data[(space_pos + 1)...null_pos]
      entries << name
      pos = null_pos + 21
    end
  end
end
