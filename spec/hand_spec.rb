require_relative '../lib/card'
require_relative '../lib/hand'

RSpec.describe Hand do

    before do
        @hand = Hand.new
    end

    it "responds to dealt_cards" do
        expect(@hand).to respond_to(:dealt_cards)
    end

    describe "#add_card" do
        it "responds to add_card" do
            expect(@hand).to respond_to(:add_card)
        end

        it "returns the correct properties of cards added" do
            card1 = Card.new("Diamonds", "Jack")
            card2 = Card.new("Clubs", "Ace")

            @hand.add_card card1
            @hand.add_card card2

            expect(@hand.dealt_cards.size).to eq(2)

            expect(@hand.dealt_cards.first.suit).to eq("Diamonds")
            expect(@hand.dealt_cards.first.rank).to eq("Jack")
            expect(@hand.dealt_cards.last.suit).to eq("Clubs")
            expect(@hand.dealt_cards.last.rank).to eq("Ace")
        end
    end

    describe "#get_value" do
        it "responds to get_value" do
            expect(@hand).to respond_to(:get_value)
        end

        it "returns correct value when there's no Ace" do
            card1 = Card.new("Diamonds", "Jack")
            card2 = Card.new("Clubs", "9")

            @hand.add_card card1
            @hand.add_card card2

            expect(@hand.get_value).to eq 19
        end

        it "returns correct value when there's an Ace and a Jack" do
            card1 = Card.new("Diamonds", "Jack")
            card2 = Card.new("Clubs", "Ace")

            @hand.add_card card1
            @hand.add_card card2

            expect(@hand.get_value).to eq 21
        end
    end

    describe "output" do
        it "returns the correct output if you can see all cards" do
            card1 = Card.new("Diamonds", "Jack")
            card2 = Card.new("Spades", "Ace")

            @hand.add_card card1
            @hand.add_card card2
            
            expect("#{@hand}").to eq("Jack of Diamonds, Ace of Spades, Total value: 21")
        end

        it "returns the correct output if you can't see one card" do
            card1 = Card.new("Diamonds", "Jack")
            card2 = Card.new("Spades", "Ace")
            card1.show = false

            @hand.add_card card1
            @hand.add_card card2

            expect("#{@hand}").to eq("Ace of Spades, Total value: 11")
        end

        it "returns the correct output if you can't see one card and first card is an Ace" do
            card1 = Card.new("Diamonds", "Ace")
            card2 = Card.new("Spades", "Jack")
            card1.show = false

            @hand.add_card card1
            @hand.add_card card2

            expect("#{@hand}").to eq("Jack of Spades, Total value: 10")
        end
    end

end