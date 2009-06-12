require "test/unit"
require File.dirname(__FILE__)+"/../lib/rubylibcrack"

class PasswordTest < Test::Unit::TestCase
  def test_password
    poor_password = Cracklib::Password.new("hello")
    assert_kind_of Cracklib::Password, poor_password
    assert !poor_password.strong?
    assert poor_password.weak?
    assert_not_nil poor_password.message

    good_password = Cracklib::Password.new("jUY d3 i5 gr38")
    assert_kind_of Cracklib::Password, good_password
    assert good_password.strong?
    assert !good_password.weak?
    assert_nil good_password.message
  end
end
