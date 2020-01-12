require 'minitest/autorun'
require_relative '../lib/deck'

class DeckTest < Minitest::Test
    SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
    RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

    def setup
        @deck = Deck.new(SUITS, RANKS)
    end

    def test_deck_responds_to_deck
        assert @deck.respond_to?(:deck)
    end

    def test_deck_responds_to_suits
        assert @deck.respond_to?(:suits)
    end

    def test_deck_responds_to_ranks
        assert @deck.respond_to?(:ranks)
    end

    def test_deck_responds_to_shuffle
        assert @deck.respond_to?(:shuffle)
    end

    def test_deck_responds_to_deal_card
        assert @deck.respond_to?(:deal_card)
    end

    def test_deck_responds_to_replace_with
        assert @deck.respond_to?(:replace_with)
    end

    def test_card_pops_off_top_when_dealt
        dealt_card = @deck.shuffle.last
        assert_equal dealt_card, @deck.deal_card
    end

    def test_gets_new_deck_with_replace_with
        deck_of_cards = []
        deck_of_cards.push(Card.new('Clubs', '2'))
        deck_of_cards.push(Card.new('Clubs', '3'))
        new_deck = @deck.dup
        new_deck.replace_with(deck_of_cards)
        refute_equal new_deck.deck, @deck.deck
    end
end