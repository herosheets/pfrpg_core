require_relative '../../../test_helper'

class RapidShotMacroTest < ActiveSupport::TestCase

  def test_slug
    rapid_shot = RapidShotMacro.new new_human
    assert_equal('RapidShot', rapid_shot.slug)
  end

  def test_name
    rapid_shot = RapidShotMacro.new new_human
    assert_equal('Rapid Shot', rapid_shot.name)
  end

  def test_available
    character = base_levelup(second_level_ranger, 'Ranger')
    character.reload
    character.choose_feat rapid_shot_feat
    character.reload

    rapid_shot = RapidShotMacro.new character
    assert(rapid_shot.available?, 'Ranger with Rapid Shot feat should have macro')
  end

  def test_not_available
    rapid_shot = RapidShotMacro.new first_level_ranger
    assert(!rapid_shot.available?, 'Ranger without Rapid Shot feat should not have macro')
  end

  def test_should_not_apply_to_short_sword
    sword = Weapon.find_by(name: 'Short Sword')
    rapid_shot = RapidShotMacro.new first_level_ranger

    assert(!rapid_shot.applies_to?(sword), 'Rapid Shot should not apply to short sword')
  end

  def test_should_apply_to_boomerang
    boomerang = Weapon.find_by(name: 'Boomerang')
    rapid_shot = RapidShotMacro.new first_level_ranger

    assert(rapid_shot.applies_to?(boomerang), 'Rapid Shot should apply to boomerang')
  end

end
