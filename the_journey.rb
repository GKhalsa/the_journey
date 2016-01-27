require 'pry'
class Tinker
  attr_reader :name, :inventory
  attr_accessor :bank

  def initialize(name)
    @name = name
    @bank = 50
    @inventory = {:items => ["mirror", "garlic"]}
  end

  def greeting
    "Hello traveller, what might you need? Some barley, some rope,or how about some mead. I'm a tinker, a travelling thinker, and if you know what's best you shall pay me some heed. Here is my cart, its depths are beyond measure, and for a piece of gold you will get what you need!"
  end

  def coin_purse
    @bank
  end
end

class Traveller
  attr_reader :name, :gold, :inventory

  def initialize(name, gold = 0)
     @name = name
     @gold = gold
     @inventory = {}
  end

  def coin_purse
    gold
  end

  def pay_the_tinker(tinker)
    @gold -= 1
    tinker.bank += 1
  end

  def purchase(tinker, item)
    if gold <= 0
      "You haven't got the coin lad"
    else
      x = tinker.inventory[:items]
      x.delete(item)
      inventory[:items] = item
      pay_the_tinker(tinker)
    end
  end

  def quest(one, two)
    if one.length != two.length
      raise ArgumentError, "No Numbers"
    else
      @gold += 1
      one = one.chars
      two = two.chars

      (0..one.length).count do |index|
        one[index] != two[index]
      end
    end
  end
end
