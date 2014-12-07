require 'minitest/autorun'
require 'pfrpg_core'
require 'pfrpg_races'
require_relative  './test_helper'

class MiscTest < Minitest::Test
  include TestHelper

  def setup
    @c = plain_character
  end

  def test_initiative
    assert @c.initiative == 0
  end

  def test_upgraded_initiative_dex
    @bonuses.plus('dex', 4)
    @c.bonuses = @bonuses
    assert @c.initiative == 2
  end

  def test_upgraded_initiative
    @bonuses.plus('initiative', 4)
    @c.bonuses = @bonuses
    assert @c.initiative == 4
  end

  def test_speed
    ['land','fly','climb','swim'].each do |type|
      assert @c.speed["#{type}_speed"] == 30
    end
  end

  class MockSlowArmor
    def slot; 'armor'; end
    def speed_thirty; 15; end
    def speed_twenty; 10; end
  end

  def test_speed_heavy
    @c.inventory = PfrpgCore::Inventory.new([MockSlowArmor.new], [])
    assert @c.speed['land_speed'] == 15
  end

  def test_speed_heavy_dwarf
    @c.race = PfrpgRaces::Race.fetch('Dwarf')
    @c.inventory = PfrpgCore::Inventory.new([MockSlowArmor.new], [])
    assert @c.speed['land_speed'] == 20
  end

  class MockMockCharacter
    def hit_points; 15; end
  end

  def test_hit_points
    @c.character = MockMockCharacter.new
    assert @c.hit_points == 15
  end

  def test_hit_points
    feats = [ PfrpgCore::Feat.new({name: 'Toughness'}) ]
    @c.character = MockMockCharacter.new
    @c.feats = feats
    # formual for toughness
    assert @c.hit_points == (15 + 3 + @c.total_level - 3)
  end

  def test_total_level
    assert @c.total_level == 10
  end

  def test_total_level_more
    @c.levels << PfrpgCore::Level.new({name: 'Rogue', number: 5})
    assert @c.total_level == 15
    assert @c.hit_die == 15
  end

end