class PfrpgCore::Effect
  attr_accessor :type, :key, :value, :affect
  def initialize(type, key, value, affect=nil)
    # standard effect proc; add a value
    basic = Proc.new do |character, attribute, value|
      character.bonuses.plus(attribute, value)
    end
    affect ||= basic
    @type   = type
    @key    = key
    @value  = value
    @affect = affect
  end

  def self.load(effects_string)
    return effects_string if effects_string.instance_of? Array
    return [ effects_string ] if effects_string.instance_of? PfrpgCore::Effect
    return [] if effects_string.nil? || effects_string.empty?
    unless effects_string.instance_of? String
      ap "Error effect: "
      ap effects_string
    end
    raise Exception unless effects_string.instance_of? String
    effects_string.split(";").map { |effect| parse_effect(effect) }
  end

  def self.parse_effect(string)
    p = string.split(":")
    type    = p[0]
    key     = p[1]
    value   = p[2]
    PfrpgCore::Effect.new(type, key, value)
  end

  def apply(character)
    @affect.call(character, @key, @value)
  end

end
