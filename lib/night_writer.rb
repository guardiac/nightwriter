class NightWriter
  attr_reader :plain_filename,
              :braille_filename,
              :plain_file,
              :braille_file

  def initialize
    @plain_filename = ARGV[0]
    @braille_filename = ARGV[1]
    read
    write
  end

  def read
    @plain_file = File.read(@plain_filename).delete("\n")
    print_output(@braille_filename, plain_file)
  end

  def write
    @braille_text = "test"
    @braille_file = File.open(@braille_filename, "w") { |f| f.write(@braille_text) }
  end

  def print_output(braille_filename, plain_file)
    puts "Created '#{braille_filename}' containing #{plain_file.length} characters"
  end
end
