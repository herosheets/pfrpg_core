require_relative '../../../test_helper'

class PowerAttackMacroTest < ActiveSupport::TestCase
  def setup
    @character = Character.new
    @character.save
  end

  def test_slug
    power_attack = PowerAttackMacro.new @character
    assert_equal(power_attack.slug, 'PowerAttack')
  end

  def test_name
    # This is a little silly I know
    power_attack = PowerAttackMacro.new @character
    assert_equal(power_attack.name, 'Power Attack')
  end

  def test_applies_to_melee_weapon
    sword = Weapon.find_by(name: 'Short Sword')
    power_attack = PowerAttackMacro.new @character

    assert power_attack.applies_to?(sword)
  end

  def test_not_apply_to_ranged_weapon
    boomerang = Weapon.find_by(name: 'Boomerang')
    power_attack = PowerAttackMacro.new @character

    assert_equal(power_attack.applies_to?(boomerang), false)
  end

  def test_available_to_char_with_power_attack_feat
    power_attack_feat = PathfinderFeat.find_by(name: 'Power Attack')
    CharFeat.create(character: @character, pathfinder_feat: power_attack_feat)

    power_attack = PowerAttackMacro.new @character
    assert power_attack.available?
  end

  def test_not_available_to_char_without_power_attack_feat
    power_attack = PowerAttackMacro.new @character
    assert_equal(power_attack.available?, false)
  end
end
