module PfrpgCore
  class Character
    include PfrpgCore::Bonus
    include PfrpgCore::Derived::CombatBonuses
    include Derived::Magic
    include Derived::Misc

    attr_reader :levels, :class_features, :feats, :inventory,
                :spells, :attributes, :saves, :alignment, :race, :saves,
                :demographics, :character_id, :character_uuid, :avatar

    def initialize(params)
      generate_effects
      @character_uuid = params[:uuid]
      @character_id   = params[:id]
      # TODO: Refactor client to remove @character
      @character      = params[:character]
      @avatar         = params[:avatar]
      @demographics   = params[:demographics]
      @race           = params[:race]
      @levels         = params[:levels]
      @alignment      = params[:alignment]
      @feats          = params[:feats]
      @class_features = params[:class_features]
      @inventory      = params[:inventory]
      @spells         = params[:spells]
      # these objects require bonuses & attributes
      @attributes     = PfrpgCore::Attributes.new(params[:attributes], @bonuses)
      @saves          = SavingThrows.new(params[:saves], @bonuses, @attributes)
      @skills         = Skills.new(params[:skills], @attributes, @race, @levels, @bonuses)
    end

    def generate_effects
      @bonuses = PfrpgCore::Bonuses.new
      @effects = PfrpgCore::EffectTotaler.new(self).effects
      e = PfrpgCore::EffectProcessor.new(self, @effects)
      e.process_effects.each do |effect|
        effect.apply(self)
      end
    end

    def name
      @demographics.character_name
    end

    def as_json(options={})
      p = {
          :id           => @character_id, #check
          :uuid         => @character_uuid, #check
          :character    => @character, #check
          :demographics => @demographics, #check
          :attributes   => @attributes, #check
          :combat       => @combat,
          :saves        => @saves, # check
          :misc         => misc_json, #check
          :skills       => @skills,
          :spells       => @spells,
          :inventory    => @inventory # check
      }
      p[:avatar] = AvatarURL.new(@avatar) if @avatar
      p
    end


  end
end