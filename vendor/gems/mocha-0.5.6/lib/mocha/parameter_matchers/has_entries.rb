require 'mocha/parameter_matchers/base'

module Mocha
  
  module ParameterMatchers

    # :call-seq: has_entries(entries) -> parameter_matcher
    #
    # Matches +Hash+ containing all +entries+.
    #   object = mock()
    #   object.expects(:method_1).with(has_entries('key_1' => 1, 'key_2' => 2))
    #   object.method_1('key_1' => 1, 'key_2' => 2, 'key_3' => 3)
    #   # no error raised
    #
    #   object = mock()
    #   object.expects(:method_1).with(has_entries('key_1' => 1, 'key_2' => 2))
    #   object.method_1('key_1' => 1, 'key_2' => 99)
    #   # error raised, because method_1 was not called with Hash containing entries: 'key_1' => 1, 'key_2' => 2
    def has_entries(entries)
      HasEntries.new(entries)
    end
    
    class HasEntries < Base # :nodoc:
      
      def initialize(entries)
        @entries = entries
      end
      
      def matches?(available_parameters)
        parameter = available_parameters.shift
        @entries.all? { |key, value| parameter[key] == value }
      end
      
      def mocha_inspect
        "has_entries(#{@entries.mocha_inspect})"
      end
      
    end
    
  end
  
end