require_relative '../../../test_helper'

class ManyshotMacroTest < ActiveSupport::TestCase

  def test_slug
    manyshot = ManyshotMacro.new new_human
    assert_equal('Manyshot', manyshot.slug)
  end

  def test_name
    manyshot = ManyshotMacro.new new_human
    assert_equal('Manyshot', manyshot.name)
  end

  def test_available
    character = base_levelup(second_level_ranger, 'Ranger')
    character.reload
    character.choose_feat manyshot_feat
    character.reload

    manyshot = ManyshotMacro.new character
    assert(manyshot.available?, 'Ranger with Manyshot feat should have macro')
  end

  def test_not_available
    manyshot = ManyshotMacro.new first_level_ranger
    assert(!manyshot.available?, 'Ranger without Manyshot feat should not have macro')
  end

  def test_should_not_apply_to_short_sword
    sword = Weapon.find_by(name: 'Short Sword')
    manyshot = ManyshotMacro.new first_level_ranger

    assert(!manyshot.applies_to?(sword), 'Manyshot should not apply to short sword')
  end

  def test_should_not_apply_to_boomerang
    boomerang = Weapon.find_by(name: 'Boomerang')
    manyshot = ManyshotMacro.new first_level_ranger

    assert(!manyshot.applies_to?(boomerang), 'Manyshot should not apply to boomerang')
  end

  def test_should_apply_to_longbow
    longbow = Weapon.find_by(name: 'Longbow, composite')
    manyshot = ManyshotMacro.new first_level_ranger

    assert(manyshot.applies_to?(longbow), 'Manyshot should apply to longbow')
  end

  def test_should_apply_to_crossbow
    crossbow = Weapon.find_by(name: 'Crossbow, heavy')
    manyshot = ManyshotMacro.new first_level_ranger

    assert(manyshot.applies_to?(crossbow), 'Manyshot should apply to crossbow')
  end

end
