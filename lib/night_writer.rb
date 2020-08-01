require './lib/line'

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
  end

  def write
    @braille_text = write_braille
    File.open(@braille_filename, "w") { |f| f.write(@braille_text) }
    @braille_file = File.read(@braille_filename)
    puts confirmation_message
  end

  def write_braille
    split_strings.reduce("") do |text, string|
      line = Line.new(string)
      text += line.render
      text += "\n" unless string == split_strings.last
      text
    end
  end

  def split_strings
    plain_file.downcase.scan(/.{1,40}/)
  end

  def confirmation_message
    "Created '#{@braille_filename}' containing #{@plain_file.length} characters"
  end
end
