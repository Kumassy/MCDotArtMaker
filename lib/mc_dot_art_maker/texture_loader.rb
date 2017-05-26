module MCDotArtMaker
  class MinecraftClientJarNotFoundError < StandardError ; end
  class UnsupportedOSError < StandardError ; end
  class UnknownOSError < StandardError ; end
  class TextureNotFoundError < StandardError ; end

  class TextureLoader
    TEXTURE_DIR = File.join(File.dirname(__FILE__),"textures")
    TEXTURE_TMP_DIR = File.join(TEXTURE_DIR,"tmp")

    def initialize(jar = nil)
      @jar = jar || jars.last
    end

    def load_texture(filename)
      filename = filename + '.png' if File.extname(filename).empty?

      confirm = [
        Dir.exist?(TEXTURE_DIR),
        File.exist?(File.join(TEXTURE_DIR,filename))
      ]

      unless confirm.all?
        # copy jar and extract
        jar_basename = File.basename(@jar)

        Dir.mkdir(TEXTURE_DIR) unless Dir.exist?(TEXTURE_DIR)
        Dir.mkdir(TEXTURE_TMP_DIR) unless Dir.exist?(TEXTURE_TMP_DIR)

        jar_file_path = File.join(TEXTURE_TMP_DIR,jar_basename)
        FileUtils.cp(@jar,jar_file_path) if Dir.glob(File.join(TEXTURE_TMP_DIR,'*.jar')).empty?

        Zip::ZipFile.open(jar_file_path) do |zip|
          zip.each do |entry|
            if md = /\Aassets\/minecraft\/textures\/blocks\/#{filename}\Z/.match(entry.to_s)
              entry.extract(File.join(TEXTURE_DIR, filename))
              return Magick::ImageList.new(File.join(TEXTURE_DIR,filename)).first
            end
          end
        end

        raise(TextureNotFoundError,"Texture \"#{filename}\" was not found") unless confirm.all?
      end

      Magick::ImageList.new(File.join(TEXTURE_DIR,filename)).first
    end

    def exist?(filename)
      filename = filename + '.png' if File.extname(filename).empty?
      [
        Dir.exist?(TEXTURE_DIR),
        File.exist?(File.join(TEXTURE_DIR,filename))
      ].all?
    end


    private
    def os
      @os ||= (
      host_os = RbConfig::CONFIG['host_os']
      case host_os
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        :windows
      when /darwin|mac os/
        :macosx
      when /linux/
        :linux
      when /solaris|bsd/
        :unix
      else
        raise(UnknownOSError,"unknown os: #{host_os.inspect}")
      end
      )
    end

    def search_dir
      case os
      when :windows
        File.join(ENV['AppData'],".minecraft", "versions")
      when :macosx
        File.join(ENV['HOME'], "Library", "Application Support", "minecraft", "versions")
      when :linux,:unix
        File.join(ENV['HOME'], ".minecraft", "versions")
      else
        raise(UnsupportedOSError,"unsupported os")
      end
    end

    def jars
      jars = Dir.glob(File.join(search_dir,"1.[8-9]{.[1-9],}")).map do |v|
        # File.join(search_dir, v,"#{v}.jar")
        basename = File.basename(v)
        File.join(v,"#{basename}.jar")
      end
      jars
    end

  end

end
