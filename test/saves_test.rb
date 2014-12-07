require 'minitest/autorun'
require 'pfrpg_core'
require_relative './test_helper'

class SavesTest < Minitest::Test

  include TestHelper

  def setup
    @bonuses = PfrpgCore::Bonuses.new
    @attributes = PfrpgCore::Attributes.new(basic_attributes, @bonuses)
  end

  def test_basc
    b = basic_saves
    saves = PfrpgCore::SavingThrows.new(b, @bonuses, @attributes)
    assert saves.reflex == 5
  end

  def test_positive_bonus
    b = basic_saves
    bonuses = PfrpgCore::Bonuses.new
    bonuses.plus('ref', 4)
    saves = PfrpgCore::SavingThrows.new(b, bonuses, @attributes)
    assert saves.reflex == 9
  end

  def test_negative_bonus
    b = basic_saves
    bonuses = PfrpgCore::Bonuses.new
    bonuses.plus('ref', -4)
    saves = PfrpgCore::SavingThrows.new(b, bonuses, @attributes)
    assert saves.reflex == 1
  end

  def test_con_bonus
    @bonuses.plus('con', 4)
    saves = PfrpgCore::SavingThrows.new(basic_saves, @bonuses, @attributes)
    assert saves.fortitude == 7
  end

  def test_wis_bonus
    @bonuses.plus('wis', -4)
    saves = PfrpgCore::SavingThrows.new(basic_saves, @bonuses, @attributes)
    assert saves.will == 3
  end

  def test_dex_bonus
    @bonuses.plus('dex', 4)
    @bonuses.plus('ref', -2)
    saves = PfrpgCore::SavingThrows.new(basic_saves, @bonuses, @attributes)
    assert saves.reflex == 5
  end
end