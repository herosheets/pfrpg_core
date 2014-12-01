module PfrpgCore
  class Character

    attr_reader :name, :level, :class_features, :feats, :inventory,
                :spells, :attributes, :saves, :alignment, :race

    def initialize(params)
      generate_effects
      @name = params[:name]
      @level = params[:level]
      @class_features = params[:class_features]
      @feats = params[:feats]
      @inventory = params[:inventory]
      @spells = params[:spells]
      @attributes = params[:attributes]
      @saves = params[:saves]
      @alignment = params[:alignment]
      @race = params[:race]
      @attributes = PfrpgCore::Attributes.new(params[:attributes], @bonuses)
      @skills     = PfrpgCore::Skills.new(params[:skills], @attributes, @race, @level, @bonuses)
    end

    def generate_effects
      @bonuses = PfrpgCore::Bonuses.new
      @effects = PfrpgCore::EffectTotaler.new(self).effects
      e = PfrpgCore::EffectProcessor.new(self, @effects)
      e.process_effects.each do |effect|
        effect.apply(self)
      end
    end
  end
end