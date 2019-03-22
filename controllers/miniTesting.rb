require 'minitest/autorun'
require_relative 'test_method'

class TestStringComparison < Minitest::Test

    def test_order
        assert_equal 0, create_order("abc", 123, 1234)   
end

    def test_user
        assert_equal 1, create_user("abcd", 1234, 123456)
    end
end

#login_functions is skipped. Because variables in login_functions are quite similar to create_functions's.