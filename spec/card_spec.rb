require_relative '../lib/card'

RSpec.describe Card do
    describe '#new' do
    let(:suit) { "Diamonds" }
    let(:rank) { "8" }

    subject(:card) { Card.new suit, rank}
      
    it "adds new card" do
        expect{card}.not_to raise_error
    end

    it"responds to suit" do
        expect(card).to respond_to(:suit)
    end
        
    it "responds to rank" do
        expect(card).to respond_to(:rank)
    end

    it "returns correct suit value" do
        expect(card.suit).to eq("Diamonds")
    end


    it "returns correct rank value" do
        expect(card.rank).to eq("8")
    end

    it "responds to 'show' method" do
        expect(card).to respond_to(:show)
    end

    it "show method returns 'true'" do
        expect(card.show).to eq(true)
    end
end

    describe "#to_s" do
    subject(:card) { Card.new "Diamonds", "8"}

    it "returns correct output if 'show' is true" do
        expect(card.to_s).to be_a(String).and eq("8 of Diamonds")
    end

    it "returns empty string if 'show' is false" do
        card.show = false
        expect(card.to_s).to be_a(String).and eq("")
    end

end
end