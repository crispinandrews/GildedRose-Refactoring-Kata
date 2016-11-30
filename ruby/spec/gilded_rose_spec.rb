require 'spec_helper'

describe GildedRose do

  let(:vest) {Item.new("+5 Dexterity Vest", 10, 20)}
  let(:brie) {Item.new("Aged Brie", 2, 0)}
  let(:elixir) {Item.new("Elixir of the Mongoose", 5, 7)}
  let(:sulfuras) {Item.new("Sulfuras, Hand of Ragnaros",10, 20)}
  let(:pass_under10) {Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 20)}
  let(:pass_under5) {Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 20)}
  let(:pass_concertover) {Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)}
  let(:item) {Item.new("Normal item", 2, 20)}
  let(:gilded_rose) {GildedRose.new([vest, brie, elixir, sulfuras, pass_under5, pass_under10, pass_concertover, item])}

  describe "#update_quality" do
    before do
      gilded_rose.update_quality()
    end
    it "does not change the name" do
      expect(gilded_rose.items[0].name).to eq "+5 Dexterity Vest"
    end

    it "does decrease the quality of an item" do
      expect(vest.quality).to eq 19
    end

    it "increases Aged Brie quality" do
      expect(brie.quality).to eq 1
    end

    it "does not decrease the quality of legendary Sulfuras" do
      expect(sulfuras.quality).to eq 20
    end

    it "increase backstage pass quality by 2 when sell_in is < 10 days" do
      expect(pass_under10.quality).to eq 22
    end

    it "increase backstage pass quality by 5 when sell_in is < 5 days" do
      expect(pass_under5.quality).to eq 23
    end

    it "decrease backstage pass quality to 0 after concert" do
      expect(pass_concertover.quality).to eq 0
    end
  end

  describe "#sell_in date" do
    before do
      gilded_rose.update_quality()
    end

    it "does decrease the sell_in value an item" do
      expect(vest.sell_in).to eq 9
    end

    it "does not decrease the sell_in value of legendary Sulfuras" do
      expect(sulfuras.sell_in).to eq 10
    end
  end
end
