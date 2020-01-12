require 'minitest/autorun'
require_relative '../lib/blackjack'

class BlackjackTest < Minitest::Test
    SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
    RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

    def setup
        @blackjack = Blackjack.new(SUITS, RANKS)
        @blackjack.deal
        @dealer_cards = @blackjack.dealer_hand.dealt_cards
        @player_cards = @blackjack.player_hand.dealt_cards
    end

    def test_blackjack_responds_to_dealer_hand
        assert @blackjack.respond_to?(:dealer_hand)
    end
    
    def test_blackjack_responds_to_player_hand
        assert @blackjack.respond_to?(:player_hand)
    end

    def test_blackjack_responds_to_playing
        assert @blackjack.respond_to?(:playing)
    end

    def test_blackjack_responds_to_current_gamer
        assert @blackjack.respond_to?(:current_gamer)
    end

    def test_blackjack_responds_to_deck
        assert @blackjack.respond_to?(:deck)
    end

    def test_blackjack_responds_to_deal
        assert @blackjack.respond_to?(:deal)
    end

    def test_blackjack_responds_to_hit
        assert @blackjack.respond_to?(:hit)
    end

    def test_blackjack_responds_to_stand
        assert @blackjack.respond_to?(:stand)
    end

    def test_blackjack_responds_to_show_hands
        assert @blackjack.respond_to?(:show_hands)
    end

    def test_blackjack_responds_to_set_results
        assert @blackjack.respond_to?(:set_results)
    end

    def test_blackjack_cards_are_dealt_for_the_dealer_and_player
        assert_equal 2, @dealer_cards.count
        assert_equal 2, @player_cards.count
    end

    def test_blackjack_dealers_first_card_is_not_displayed
        assert_equal false, @dealer_cards.first.show
    end

    def test_players_turn_ends_if_he_has_a_blackjack
        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "Ace")
        card3 = Card.new("Clubs", "3")

        card4 = Card.new("Diamonds", "10")
        card5 = Card.new("Diamonds", "King")
        card6 = Card.new("Hearts", "Queen")

        @blackjack = Blackjack.new(SUITS, RANKS)
        new_deck = [card4, card5, card2, card3, card1, card6]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal

        assert_equal "Dealer", @blackjack.current_gamer
    end

    def test_hit_when_playing_is_true
        assert_equal true, @blackjack.playing
    end

    def test_returns_2_cards_for_dealer_after_players_hit_player_has_3
        @blackjack.hit
        assert_equal 2, @dealer_cards.count
        assert_equal 3, @player_cards.count
    end

    def test_correctly_determines_if_player_gets_busted
        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "10")
        card3 = Card.new("Diamonds", "2")

        card4 = Card.new("Spades", "10")
        card5 = Card.new("Clubs", "10")
        card6 = Card.new("Hearts", "Queen")

        @blackjack = Blackjack.new(SUITS, RANKS)

        new_deck = [card6, card3, card2, card5, card1, card4]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal
        @blackjack.hit

        assert_equal "Player busted!", @blackjack.result
    end

    def test_correctly_determines_if_dealer_gets_busted
        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "10")
        card3 = Card.new("Diamonds", "Ace")

        card4 = Card.new("Spades", "10")
        card5 = Card.new("Clubs", "10")
        card6 = Card.new("Hearts", "Queen")

        @blackjack = Blackjack.new(SUITS, RANKS)

        new_deck = [card6, card3, card2, card5, card1, card4]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal
        @blackjack.hit

        @blackjack.current_gamer = "Dealer"
        @blackjack.hit

        assert_equal "Dealer busted!", @blackjack.result
    end

    def test_gamer_switches_to_dealer_when_player_stands
        @blackjack = Blackjack.new(SUITS, RANKS)

        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "10")
        card3 = Card.new("Diamonds", "Ace")

        card4 = Card.new("Spades", "10")
        card5 = Card.new("Clubs", "3")
        card6 = Card.new("Hearts", "Queen")

        new_deck = [card6, card3, card2, card5, card1, card4]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal
        @blackjack.hit
        @blackjack.stand

        assert_equal "Dealer", @blackjack.current_gamer
    end

    def test_dealer_automatically_hits_if_value_is_less_then_17_and_first_card_shown
        @blackjack = Blackjack.new(SUITS, RANKS)

        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "10")
        card3 = Card.new("Diamonds", "Ace")

        card4 = Card.new("Spades", "10")
        card5 = Card.new("Clubs", "3")
        card6 = Card.new("Hearts", "Queen")

        new_deck = [card6, card3, card2, card5, card1, card4]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal

        assert_equal 13, @blackjack.dealer_hand.get_value

        @blackjack.hit
        @blackjack.stand

        assert_equal 23, @blackjack.dealer_hand.get_value
        assert_equal true, @blackjack.dealer_hand.dealt_cards.first.show
    end

    def test_sets_correct_result_when_player_gets_busted
        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "10")
        card3 = Card.new("Diamonds", "2")

        card4 = Card.new("Spades", "10")
        card5 = Card.new("Clubs", "10")
        card6 = Card.new("Hearts", "Queen")

        @blackjack = Blackjack.new(SUITS, RANKS)
        new_deck = [card6, card3, card2, card5, card1, card4]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal
        @blackjack.hit

        assert_equal "Player busted!", @blackjack.set_results
    end

    def test_sets_correct_result_when_dealet_gets_busted
        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "10")
        card3 = Card.new("Diamonds", "Ace")

        card4 = Card.new("Spades", "10")
        card5 = Card.new("Clubs", "10")
        card6 = Card.new("Hearts", "Queen")

        @blackjack = Blackjack.new(SUITS, RANKS)
        new_deck = [card6, card3, card2, card5, card1, card4]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal
        @blackjack.hit
        @blackjack.stand
        @blackjack.hit

        assert_equal "Dealer busted!", @blackjack.set_results
    end

    def test_sets_correct_result_when_theres_a_tie
        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "10")
        card3 = Card.new("Diamonds", "Ace")

        card4 = Card.new("Spades", "10")
        card5 = Card.new("Clubs", "10")
        card6 = Card.new("Hearts", "Ace")

        @blackjack = Blackjack.new(SUITS, RANKS)
        new_deck = [card6, card3, card2, card5, card1, card4]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal
        @blackjack.hit
        @blackjack.stand
        @blackjack.hit

        assert_equal "That's a tie!", @blackjack.set_results
    end

    def test_sets_correct_result_when_player_wins
        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "10")
        card3 = Card.new("Diamonds", "Ace")

        card4 = Card.new("Spades", "10")
        card5 = Card.new("Clubs", "9")
        card6 = Card.new("Hearts", "Ace")

        @blackjack = Blackjack.new(SUITS, RANKS)
        new_deck = [card6, card3, card2, card5, card1, card4]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal
        @blackjack.hit
        @blackjack.stand
        @blackjack.hit

        assert_equal "Player wins!", @blackjack.set_results
    end

    def test_sets_correct_result_when_player_loses
        card1 = Card.new("Clubs", "10")
        card2 = Card.new("Hearts", "9")
        card3 = Card.new("Diamonds", "Ace")

        card4 = Card.new("Spades", "10")
        card5 = Card.new("Clubs", "10")
        card6 = Card.new("Hearts", "Ace")

        @blackjack = Blackjack.new(SUITS, RANKS)
        new_deck = [card6, card3, card2, card5, card1, card4]
        @blackjack.deck.replace_with new_deck
        @blackjack.deal
        @blackjack.hit
        @blackjack.stand
        @blackjack.hit

        assert_equal "Player lost!", @blackjack.set_results
    end
end