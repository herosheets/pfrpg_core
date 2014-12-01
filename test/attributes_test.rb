require 'minitest/autorun'
require 'pfrpg_core'


class AttributesTest < Minitest::Test

  def basic_attributes
    {
        raw_int: 10,
        raw_wis: 10,
        raw_dex: 10,
        raw_con: 10,
        raw_cha: 10,
        raw_str: 10
    }
  end

  def test_max_dex_bonus
    b = basic_attributes
    b[:max_dex] = 4
    b[:raw_dex] = 20
    attributes = PfrpgCore::Attributes.new(b, PfrpgCore::Bonuses.new)
    assert attributes.dex_mod == 4
  end

  def test_max_dex_bonus
    b = basic_attributes
    b[:max_dex] = 6
    b[:raw_dex] = 20
    attributes = PfrpgCore::Attributes.new(b, PfrpgCore::Bonuses.new)
    assert attributes.dex_mod == 5
  end

  def test_negative_bonus
    b = basic_attributes
    b[:raw_str] = 8
    attributes = PfrpgCore::Attributes.new(b, PfrpgCore::Bonuses.new)
    assert attributes.str_mod == -1
  end

  def test_positive_bonus
    b = basic_attributes
    b[:raw_wis] = 12
    attributes = PfrpgCore::Attributes.new(b, PfrpgCore::Bonuses.new)
    assert attributes.wis_mod == 1
  end

  def test_zero_bonus
    attributes = PfrpgCore::Attributes.new(basic_attributes, PfrpgCore::Bonuses.new)
    assert attributes.cha_mod == 0
  end

  def test_additional_bonus
    bonuses = PfrpgCore::Bonuses.new
    bonuses.plus('con', 4)
    attributes = PfrpgCore::Attributes.new(basic_attributes, bonuses)
    assert attributes.con_mod == 2
  end

end