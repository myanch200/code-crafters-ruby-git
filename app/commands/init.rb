# frozen_string_literal: true

# Commands module
module Commands
  def self.init
    # Create the necessary directories and files for a basic git repository
    Dir.mkdir('.git') unless Dir.exist?('.git')
    Dir.mkdir('.git/objects') unless Dir.exist?('.git/objects')
    Dir.mkdir('.git/refs') unless Dir.exist?('.git/refs')
    File.write('.git/HEAD', "ref: refs/heads/main\n")
    puts 'Initialized git directory'
  rescue StandardError => e
    puts "Error initializing git directory: #{e.message}"
  end
end
