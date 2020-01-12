require 'minitest/autorun'
require_relative '../lib/card'

class CardTest < Minitest::Test

    def setup
        @card = Card.new("Diamonds", "8")
    end

    def test_card_responds_to_suit
        assert @card.respond_to?(:suit)
    end

    def test_card_responds_to_rank
        assert @card.respond_to?(:rank)
    end

    def test_card_responds_to_show
        assert @card.respond_to?(:show)
    end

    def test_show_returns_true
        assert_equal true, @card.show
    end

    def test_suit_returns_Diamonds
        assert_equal "Diamonds", @card.suit
    end

    def test_rank_returns_8
        assert_equal "8", @card.rank
    end

    def test_output_is_rank_and_suit_if_show_is_true
        assert_equal "8 of Diamonds", @card.to_s
    end

    def test_does_not_output_anything_if_show_is_false
        @card.show = false
        assert_equal "", @card.to_s
    end
end