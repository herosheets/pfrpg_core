module PfrpgCore
  class Attributes

    attr_accessor :raw_int, :raw_dex, :raw_str,
                :raw_con, :raw_wis, :raw_cha,
                :max_dex

    def initialize(attributes,bonuses=Bonuses.new)
      @raw_int = attributes[:raw_int]
      @raw_con = attributes[:raw_con]
      @raw_str = attributes[:raw_str]
      @raw_wis = attributes[:raw_wis]
      @raw_cha = attributes[:raw_cha]
      @raw_dex = attributes[:raw_dex]
      @max_dex = attributes[:max_dex] || 1000
      @bonuses = bonuses
    end

    def set_bonuses(bonuses)
      @bonuses = bonuses
    end

    def modified_int
      get_modified('int')
    end

    def int_mod
      get_modifier(modified_int)
    end

    def modified_dex
      get_modified('dex')
    end

    def dex_mod
      # TODO : feats let you overcome this
      dex = get_modifier(modified_dex)
      max = @max_dex
      dex = max if (dex > max)
      dex
    end

    def modified_str
      get_modified('str')
    end

    def str_mod
      get_modifier(modified_str)
    end

    def modified_con
      get_modified('con')
    end

    def con_mod
      get_modifier(modified_con)
    end

    def modified_cha
      get_modified('cha')
    end

    def cha_mod
      get_modifier(modified_cha)
    end

    def modified_wis
      get_modified('wis')
    end

    def wis_mod
      get_modifier(modified_wis)
    end

    def get_modified(attribute)
      base = self.send("raw_#{attribute}") || 0
      base += NullObject.maybe(@bonuses.get(attribute)).to_i
      base
    end

    def get_modifier(val)
      return ((val - 10) / 2.0).floor
    end


    def as_json(options={})
      {
          :values => {
              :strength => modified_str,
              :dexterity => modified_dex,
              :charisma => modified_cha,
              :wisdom => modified_wis,
              :constitution => modified_con,
              :intelligence => modified_int
          },
          :modifier => {
              :strength => str_mod,
              :dexterity => dex_mod,
              :charisma => cha_mod,
              :wisdom => wis_mod,
              :constitution => con_mod,
              :intelligence => int_mod
          }
      }
    end
  end
end