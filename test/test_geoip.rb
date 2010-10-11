require File.dirname(__FILE__) + '/test_helper.rb'

class TestGeoip < Test::Unit::TestCase

  def setup
    @dummy = Dummy.new
  end
  
  def test_objects_are_geolocatable
    assert_not_nil @dummy.country
  end
  
  def test_gem_can_install_binaries
    assert_nothing_raised do
      Autometal::Geoip::Installer.new("GeoLiteCity")
    end
    assert_equal true, Autometal::Geoip.bin_installed?
    assert_not_nil @dummy.country, "Country should not be nil"
    assert_not_nil @dummy.city, "City should not be nil"
    assert_not_nil @dummy.lat, "Latitude should not be nil"
    assert_not_nil @dummy.lng, "Longitude should not be nil"
  end
end
