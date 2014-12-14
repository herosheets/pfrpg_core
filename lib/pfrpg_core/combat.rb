module PfrpgCore
  class Combat
    include Derived::Defense
    include Derived::Offense

    attr_reader :character, :str_bonus, :dex_bonus, :bab,
                :weapon_finesse, :size_modifier, :deflection_modifier, :dodge_modifier,
                :armor_ac, :shield_ac, :natural_armor, :max_dex_bonus, :armor_check_penalty,
                :damage_reduction, :spell_resistance, :armor_modifier

    def initialize(character)
      @character = character
      @str_bonus = NullObject.maybe(character.attributes.str_mod)
      @dex_bonus = NullObject.maybe(character.attributes.dex_mod)
      @bab = NullObject.maybe(character.get_highest_attack_bonus)
      @weapon_finesse = false
      @dodge_modifier = NullObject.maybe(character.get_dodge_modifier)
      @deflection_modifier = NullObject.maybe(character.get_deflection_modifier)
      @armor_ac = NullObject.maybe(character.inventory.get_armor_ac)
      @shield_ac = NullObject.maybe(character.inventory.get_shield_ac)
      @natural_armor = NullObject.maybe(character.get_natural_armor)
      @size_modifier = NullObject.maybe(character.get_size_modifier)
      @armor_check_penalty = NullObject.maybe(character.get_ac_penalty)
      @max_dex_bonus = NullObject.maybe(character.get_max_dex_bonus)
      @spell_resistance = NullObject.maybe(character.get_spell_resistance)
      @damage_reduction = NullObject.maybe(character.get_damage_reduction)
      @armor_modifier = NullObject.maybe(character.get_armor_modifier)
    end

    def as_json(options={})
      {
          :str_bonus      => @str_bonus,
          :dex_bonus      => @dex_bonus,
          :bab            => @bab,
          :weapon_finesse => @weapon_finesse,
          :dodge_modifier => @dodge_modifier,
          :armor_modifier => @armor_modifier,
          :deflection_modifier => @deflection_modifier,
          :armor_ac       => @armor_ac,
          :shield_ac      => @shield_ac,
          :natural_armor  => @natural_armor,
          :size_modifier  => @size_modifier,
          :armor_class    => armor_class,
          :flat_footed_ac => flat_footed_ac,
          :cmd            => combat_maneuver_defense,
          :touch_ac       => touch_ac,
          :spell_resistance => spell_resistance,
          :damage_reduction => damage_reduction,
          :attacks        => attacks,
          :cmb            => combat_maneuver_bonus
      }
    end

    private
    def base_ac
      10
    end

  end
end
