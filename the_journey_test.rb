require 'minitest/autorun'
require 'minitest/pride'
require_relative 'the_journey.rb'
require_relative '../mythical-creatures/medusa.rb'
require 'pry'

class JourneyTest < Minitest::Test

  # def self.get_name
  #   puts "You are beginning a long and arduous journey. Tell me your name kind traveller"
  #   @name = gets
  # end
  # JourneyTest.get_name


  def test_does_the_tinker_have_a_name

    tinker = Tinker.new("Sunny")
    assert_equal "Sunny", tinker.name
  end

  def test_what_is_a_tinker

    tinker = Tinker.new("Sunny")
    assert_equal "Hello traveller, what might you need? Some barley, some rope,or how about some mead. I'm a tinker, a travelling thinker, and if you know what's best you shall pay me some heed. Here is my cart, its depths are beyond measure, and for a piece of gold you will get what you need!",
    tinker.greeting
  end

  def test_who_are_you

    traveller = Traveller.new("S")
    assert traveller.name.length != 0
  end

  def test_traveller_starts_with_zero_gold
    traveller = Traveller.new("S", 0)
    assert traveller.name.length != 0
    assert_equal 0, traveller.coin_purse
  end

  def test_finishing_a_quest_is_rewarded_with_gold

    traveller = Traveller.new("S")
    assert traveller.name.length != 0
    traveller.quest('A', 'A')
    assert_equal 1, traveller.coin_purse
  end

  def test_you_really_thought_finishing_a_quest_was_that_easy

    traveller = Traveller.new("S")
    assert traveller.name.length != 0
    assert_equal 0, traveller.quest('A', 'A')
    assert_equal 1, traveller.quest('A', 'B')
    assert_equal 2, traveller.coin_purse
  end

  def test_the_tinker_has_a_variety_of_items

    tinker = Tinker.new("Terrowin")
    items = {:items => ["mirror", "garlic"]}
    assert_equal items, tinker.inventory
  end

  def test_you_can_pay_the_tinker

    tinker = Tinker.new("Hadrian")
    traveller = Traveller.new("S")
    assert traveller.name.length != 0
    assert_equal 1, traveller.quest('AB', 'AA')

    assert_equal 50, tinker.coin_purse
    assert_equal 1, traveller.coin_purse
    traveller.pay_the_tinker(tinker)
    assert_equal 51, tinker.coin_purse
    assert_equal 0, traveller.coin_purse
  end

  def test_a_proper_quest_is_a_good_quest
    traveller = Traveller.new("S")
    assert traveller.name.length != 0
    assert_raises(ArgumentError) { traveller.quest('AB', 'ABA') }
  end

  def test_you_can_purchase_items
    tinker = Tinker.new("Cromwell")
    traveller = Traveller.new("S")
    assert_equal 2, traveller.quest('AB', 'CD')

    assert_equal Hash.new, traveller.inventory
    items = {:items => ["mirror", "garlic"]}
    assert_equal items, tinker.inventory

    traveller.purchase(tinker, "mirror")
    assert traveller.inventory.has_value?('mirror')

    refute tinker.inventory.has_value?('mirror')
    assert_equal 0, traveller.coin_purse
  end

  def test_you_cannot_purchase_items_if_you_do_not_have_money
    tinker = Tinker.new("Svallingson")
    traveller = Traveller.new("S")

    assert_equal Hash.new, traveller.inventory
    items = {:items => ["mirror", "garlic"]}
    assert_equal items, tinker.inventory

    assert_equal "You haven't got the coin lad",   traveller.purchase(tinker, "mirror")
  end

  def test_things_start_to_get_interesting

    traveller = Traveller.new("S")
    medusa = Medusa.new("Cassiopeia")
    assert traveller.name.length != 0

    medusa.stare(traveller)
    assert_equal 1, medusa.statues.count
    assert_equal traveller.object_id, medusa.statues[0].object_id
  end

  def test_traveller_is_safe_if_he_has_a_mirror

    tinker = Tinker.new("Adelaide")
    traveller = Traveller.new("S")
    medusa = Medusa.new("Cassiopeia")
    assert traveller.name.length != 0

    traveller.quest('AB', 'CD')
    traveller.purchase(tinker, "mirror")
    #insert code here to give your traveller a mirror
    #make sure your medusa tests still pass!
    medusa.stare(traveller)
    assert_equal 0, medusa.statues.count
  end

  def test_the_tinker_only_has_one_mirror

    tinker = Tinker.new("Guinevere")
    traveller = Traveller.new("S")
    traveller_companion = Traveller.new("Spindleshanks")

    assert_equal 225, traveller.quest_two(5)
    assert_equal 1, traveller.coin_purse
    assert_equal 3025, traveller_companion.quest_two(10)
    assert_equal 1, traveller_companion.coin_purse

    traveller.purchase(tinker, "mirror")

    assert_equal "I'm afraid I'm fresh out", traveller_companion.purchase(tinker, "mirror")
  end

  def test_the_wizard_comes_to_your_aid
    traveller = Traveller.new("")
    traveller_companion = Traveller.new("Spindleshanks")

    #write code to give your traveller a mirror
    #write code to have medusa stare at both of your travellers

    assert_equal "Spindleshanks", medusa.statues.first.name

    #just when you thought you were doomed, without hope, engulfed by despair... yeah, yeah I think you get it, the wizard cheek makes an appearence!

    wizard = Wizard.new("Cheek")
    assert_equal "Hello y'all, so I know what you're thinking, old
    Josh here is coming in to save the day. Well not today, you need
    to believe in yourself, you can totally do it!

    *cue epic montage*
    -Bam! you now have a new power - ~power of vim~ -

    Hey, if we got time later, let's draw some stuff in the browser.
    The browser? you say... say what time period is this, whoops...
    I'm outa here , outa here, outa here(*say that to yourself in a
    echo'ey kind of way*)", wizard.dontUsecamelCaseshere

    traveller.power_of_vim
    assert_equal 0, medusa.statues.count
    #"oh and before I forget, take this with you", says the wizard
    items = {:magic_items => "wolfsbane"}
    assert_equal items, traveller.inventory
  end

    #You and your companion have now been travelling for 3 fortnights when you stumble upon a hidden entrance in the middle of a hollowed out willow tree. Your companion is a bit hesitant, but your curiosity wins out and you now find yourself going deeper and deeper into what appears to be a dungeon. You are about to turn around when a man in tattered clothes suddenly blocks the exit. "Who dares enter the lair of Horace!", he growls...

  def test_encountering_a_werewolf
    skip
    traveller = Traveller.new("")
    traveller_companion = Traveller.new("Deborah")
    werewolf = Werewolf.new("Horace", "The Black Forest")

    werwolf.change!
    assert werewolf.werewolf?

    werewolf.bite
    refute traveller.bitten?
    werewolf.bite
    refute traveller.bitten?
  end

    #huh, what is going on? You keep on trying to bite me, yet there is no pain or bite marks?? - traveller

    #growl, yarp, you... you have discovered my dark secret. I.. I am a werewolf with no teeth. It's a sad existance, please help me. - werewolf

  def test_give_the_werwolf_wolfsbane
    skip
    traveller = Traveller.new("")
    traveller_companion = Traveller.new("Deborah")
    werewolf = Werewolf.new("Horace", "The Black Forest")
    assert traveller.name.length != 0

    assert_equal nil, werewolf.inventory
    assert_equal "What is that!? Is that wolfsbane!? Are you trying to kill me?", traveller.give_item("wolfsbane")
    #have this quote come from the werewolf class
  end

    # Your traveller in despair splits off from the companion, going deeper and deeper into uncharted and trecherous territory in search of answers...

  def test_meeting_a_sphinx
    skip
    traveller = Traveller.new("")
    sphinx = Sphinx.new("Erenna")
    assert_equal "Erenna", sphinx.name

    #I sense a soul in search of answers. You wish to know how to cure the werewolf of his malady. I have the answer, but first you must complete my challange. - sphinx

    assert_equal 'I', traveller.sphinx_challange(1)
    assert_equal 'II', traveller.sphinx_challange(2)
    assert_equal 'III', traveller.sphinx_challange(3)
    assert_equal 'IV', traveller.sphinx_challange(4)
    assert_equal 'V', traveller.sphinx_challange(5)
    assert_equal 'VI', traveller.sphinx_challange(6)
    assert_equal 'IX', traveller.sphinx_challange(9)
    assert_equal 'XXVII', traveller.sphinx_challange(27)
    assert_equal 'XLVIII', traveller.sphinx_challange(48)
    assert_equal 'LIX', traveller.sphinx_challange(59)

    #You are a mighty traveller whose wisdom is beyond bounds! Here is your reward!
    items = {:magical_items => "wolfsbane", :items => "pizza"}
    assert_equal items, traveller.inventory

    #You need to put the wolfsbane on top of the pizza for the cure to work! - sphinx
  end

  def test_curing_the_werewolf
    skip
    traveller = Traveller.new("")
    werewolf = Werewolf.new("Horace", "The Black Forest")

    assert_equal nil, werewolf.inventory
    assert_equal "I thought the daft malevolent transformations would never end! Thank you kind traveller!", traveller.give_item("wolfsbane","pizza")
    #have the words come from the werewolf class
    items = {:magical_items => "wolfsbane", :items => "pizza"}
    assert_equal items, werewolf.inventory
    assert_equal nil, traveller.inventory

    werewolf.take_items
    assert_equal nil, werewolf.inventory
    assert werewolf.human
    werewolf.change!
    assert werewolf.human
  end

  def test_completion
    skip
    traveller = Traveller.new("")
    assert traveller.name.length != 0
    assert_equal 'You rock', traveller.finale
  end
end


# [ ∆,
#  ∆,∆ ]
