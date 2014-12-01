class Feat
  attr_reader :name, :description, :effects, :prereqs
  def initialize(name, description, effects, prereqs)
    @name = name
    @description = description
    @effects = effects || []
    @prereqs = prereqs || []
  end


end