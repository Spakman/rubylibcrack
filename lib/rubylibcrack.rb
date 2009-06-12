require 'rubygems'
require 'ffi'

module Cracklib
  class Password
    attr_reader :message

    extend FFI::Library
    ffi_lib "crack", "/usr/lib/libcrack.so", "/lib/libcrack.so"
    attach_function :check, "FascistCheck", [ :string, :string ], :string
    POTENTIAL_DICT_PATHS = %w(/usr/share/cracklib/pw_dict /usr/lib/cracklib_dict /usr/lib64/cracklib_dict /var/cache/cracklib/cracklib_dict)
    @@dictpath = ""

    def initialize(password)
      @password = password
    end

    def strong?(dictpath = default_dictpath)
      if not valid_dictpath? dictpath
        raise "#{dictpath} is not a valid dictionary path!"
      end
      begin
        @message = check(@password, dictpath)
      rescue
        return true
      end
      return false
    end

    def weak?(dictpath = default_dictpath)
      not strong? dictpath
    end
    
    protected

    def default_dictpath
      if @@dictpath.empty?
        POTENTIAL_DICT_PATHS.each do |path|
          if valid_dictpath? path
            @@dictpath = path
            break
          end
        end
      end
      @@dictpath
    end

    def valid_dictpath?(dictpath)
      if File.exists? dictpath+'.hwm' and File.exists? dictpath+'.pwi' and File.exists? dictpath+'.pwd'
        true
      else
        false
      end
    end
  end
end
