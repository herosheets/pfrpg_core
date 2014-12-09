require_relative '../../../test_helper'

class SneakAttackMacroTest < ActiveSupport::TestCase

  def test_slug
    sneak_attack = SneakAttackMacro.new new_human
    assert_equal('SneakAttack', sneak_attack.slug)
  end

  def test_applies_to_rogues
    sneak_attack = SneakAttackMacro.new first_level_rogue
    assert(sneak_attack.available?, 'First level Rogue should have sneak attack')
  end

  def test_does_not_apply_to_druid
    sneak_attack = SneakAttackMacro.new second_level_druid
    assert(!sneak_attack.available?, 'Second level Druid should not have sneak attack')
  end

  def test_level_one_name
    sneak_attack = SneakAttackMacro.new first_level_rogue
    assert_equal('Sneak Attack (level 1)', sneak_attack.name)
  end

  def test_level_two_name
    sneak_attack = SneakAttackMacro.new third_level_rogue
    assert_equal('Sneak Attack (level 2)', sneak_attack.name)
  end

  def test_level_one_rogue_info
    sneak_attack = SneakAttackMacro.new first_level_rogue
    assert_equal({ sneakAttackLevel: 1 }, sneak_attack.info)
  end

  def test_level_two_rogue_info
    sneak_attack = SneakAttackMacro.new second_level_rogue
    assert_equal({ sneakAttackLevel: 1 }, sneak_attack.info)
  end

  def test_level_three_rogue_info
    sneak_attack = SneakAttackMacro.new third_level_rogue
    assert_equal({ sneakAttackLevel: 2 }, sneak_attack.info)
  end

end
