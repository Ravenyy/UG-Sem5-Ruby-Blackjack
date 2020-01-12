require 'minitest/autorun'
require_relative '../lib/hand'
require_relative '../lib/card'

class HandTest < Minitest::Test
    
    def setup
        @hand = Hand.new
    end

    def test_hand_responds_to_dealt_cards
        assert @hand.respond_to?(:dealt_cards)
    end

    def test_hand_responds_to_add_card
        assert @hand.respond_to?(:add_card)
    end

    def test_hand_returns_correct_size_after_adding_cards
        card1 = Card.new("Diamonds", "Jack")
        card2 = Card.new("Clubs", "Ace")

        @hand.add_card card1
        @hand.add_card card2

        assert_equal 2, @hand.dealt_cards.size
    end

    def test_hand_returns_correct_properties_of_cards_added
        card1 = Card.new("Diamonds", "Jack")
        card2 = Card.new("Clubs", "Ace")

        @hand.add_card card1
        @hand.add_card card2

        assert_equal "Diamonds", @hand.dealt_cards.first.suit
        assert_equal "Jack", @hand.dealt_cards.first.rank
        assert_equal "Clubs", @hand.dealt_cards.last.suit
        assert_equal "Ace", @hand.dealt_cards.last.rank
    end

    def test_hand_responds_to_get_value
        assert @hand.respond_to?(:get_value)
    end

    def test_hand_returns_correct_value_when_theres_no_ace
        card1 = Card.new("Diamonds", "Jack")
        card2 = Card.new("Clubs", "9")

        @hand.add_card card1
        @hand.add_card card2

        assert_equal 19, @hand.get_value
    end

    def test_hand_returns_correct_value_when_ace_is_worth_11
        card1 = Card.new("Diamonds", "Jack")
        card2 = Card.new("Clubs", "Ace")

        @hand.add_card card1
        @hand.add_card card2
        
        assert_equal 21, @hand.get_value
    end

    def test_hand_returns_correct_output_when_nothings_hidden
        card1 = Card.new("Diamonds", "Jack")
        card2 = Card.new("Clubs", "Ace")

        @hand.add_card card1
        @hand.add_card card2

        assert_equal "Jack of Diamonds, Ace of Clubs, Total value: 21", @hand.to_s
    end

    def test_hand_returns_correct_output_when_one_card_is_hidden
        card1 = Card.new("Diamonds", "Jack")
        card2 = Card.new("Clubs", "Ace")
        card1.show = false

        @hand.add_card card1
        @hand.add_card card2

        assert_equal "Ace of Clubs, Total value: 11", @hand.to_s
    end

    def test_hand_returns_correct_output_when_ace_is_hidden
        card1 = Card.new("Diamonds", "Ace")
        card2 = Card.new("Spades", "Jack")
        card1.show = false

        @hand.add_card card1
        @hand.add_card card2

        assert_equal "Jack of Spades, Total value: 10", @hand.to_s
    end
end