require "fileutils"
module Autometal
  class Geoip
=begin rdoc
  Installer class that handles downloading and installing databases and binaries
=end
    class Installer
      BASE_DB_URL = "http://geolite.maxmind.com/download/geoip/database/*.dat.gz"
      PACKAGE_URL = "http://geolite.maxmind.com/download/geoip/api/c/GeoIP.tar.gz"

      def initialize package_name = "GeoLiteCity"
        @package_name = package_name
        @db_url = BASE_DB_URL.gsub("*",@package_name)
        install_binary
        install_database
      end

    private
      def install_binary
        if Autometal::Geoip.bin_installed?
          puts "Binary already installed, skipping"
        else
          `cd #{File.dirname(__FILE__)}/../../shellscripts/ && ./install_binary #{PACKAGE_URL}` 
        end
      end

      def install_database
        target = File.join(Autometal::Geoip::DATA_FILE_PATH,"#{@package_name}.dat")
        if File.exists?(target) and File::ctime(target) > Time.now - (30*24*60*60)
          puts "Datafile is up to date, skipping"
        else
          `cd #{File.dirname(__FILE__)}/../../shellscripts/ && ./install_db #{@db_url}`
        end
      end
    end
  end
end