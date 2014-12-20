module PfrpgCore
  class Item
    include Affectable
    attr_reader :name, :description, :slot, :type, :equipped, :effects,
                :cost, :dmg_s, :dmg_m, :critical_range, :critical_dmg,
                :range, :weight, :dmg_type, :special, :source, :weapon_type,
                :weight_class, :ac_bonus, :max_dex_bonus, :armor_check_penalty,
                :arcane_spell_failure_chance, :speed_twenty, :speed_thirty

    def initialize(item, equipped)
      @name = item[:name]
      @description = item[:description]
      @slot = item[:slot]
      @type = item[:type]
      @effects = item[:effects]
      @cost = item[:cost]
      @dmg_m = item[:dmg_m]
      @dmg_s = item[:dmg_s]
      @critical_range = item[:critical_range]
      @critical_dmg = item[:critical_dmg]
      @range = item[:range]
      @weight = item[:weight]
      @dmg_type = item[:dmg_type]
      @special = item[:special]
      @source = item[:source]
      @weapon_type = item[:weapon_type]
      @weight_class = item[:weight_class]
      @ac_bonus = item[:ac_bonus]
      @max_dex_bonus = item[:max_dex_bonus]
      @armor_check_penalty = item[:armor_check_penalty]
      @arcane_spell_failure_chance = item[:arcane_spell_failure_chance]
      @speed_twenty = item[:speed_twenty]
      @speed_thirty = item[:speed_thirty]
      @equipped = equipped
    end

    def applies_strength_dmg?
      ['light', 'one-handed', 'two-handed'].include?(weight_class.downcase) ||
          name == 'Sling'
    end
  end
end