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
  attr_accessor :stoned

  def initialize(name, gold = 0)
     @name = name
     @gold = gold
     @inventory = {}
     @stoned = false
  end

  def coin_purse
    gold
  end

  def pay_the_tinker(tinker)
    @gold -= 1
    tinker.bank += 1
  end

  def quest_items(items)
    inventory[:magic_items] = items
  end

  def purchase(tinker, item)
    x = tinker.inventory[:items]
    if gold <= 0
      "You haven't got the coin lad"
    elsif x.include?(item) == false
      "I'm afraid I'm fresh out"
    else
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

  def power_of_vim(medusa)
    medusa.unstoned << medusa.statues.shift
    medusa.unstoned[0].stoned = false
  end

  def quest_two(num)
    @gold += 1
    (0..num).reduce(:+)**2
  end

  def bitten?
  end

  def give_item(item)
    werewolf = Werewolf.new("Horace", "The Black Forest")
    werewolf.response
  end
end

class Sphinx
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def sphinx_challenge(num)
    key = {1000 => 'M',
      900 => 'CM',
       500 => 'D',
        400 => 'CD',
         100 => "C",
          90 => "XC",
           50 => "L",
            40 => "XL",
             10 => "X",
              9 => "IX",
               5 => "V",
                4 => "IV",
                 1 => "I"}
    numeral = ''
    key.each do |arabic, roman_numeral|
      while num >= arabic
        num = num -= arabic
        numeral << roman_numeral
      end
    end
    numeral
  end

  def roman_numeral(num)
    key = {1000 => 'M',
      900 => 'CM',
       500 => 'D',
        400 => 'CD',
         100 => "C",
          90 => "XC",
           50 => "L",
            40 => "XL",
             10 => "X",
              9 => "IX",
               5 => "V",
                4 => "IV",
                 1 => "I"}
    numeral = ''
    key.each do |arabic, roman_numeral|
      while num >= arabic
        num = num -= arabic
        numeral << roman_numeral
      end
    end
    numeral
  end

end
