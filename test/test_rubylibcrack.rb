require "test/unit"
unless File.exist?(File.dirname(__FILE__)+"/../ext/rubylibcrack.so")
  puts "You must build the extension before running these tests. The rake task :test calls the :build_extension task and does all this for you."
  puts 'Alternatively, you can run this command: "cd ext; ruby extconf.rb; make; cd ../"'
  exit 0
end
require File.dirname(__FILE__)+"/../ext/rubylibcrack"

class PasswordTest < Test::Unit::TestCase
  def test_password
    poor_password = Password.new("hello")
    assert_kind_of Password, poor_password
    assert !poor_password.strong?
    assert poor_password.weak?
    assert_not_nil poor_password.message

    good_password = Password.new("jUY d3 i5 gr38")
    assert_kind_of Password, good_password
    assert good_password.strong?
    assert !good_password.weak?
    assert_nil good_password.message
  end
end
