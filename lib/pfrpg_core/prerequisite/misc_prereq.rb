class PfrpgCore::Prerequisite::MiscPrereq < PfrpgCore::Prerequisite
  def match(character)
    begin
      case @attribute
      when "caster level"
        return character.get_caster_level >= @value.to_i
      when "total_level"
        return character.get_total_level >= @value.to_i
      when "caster"
        return character.can_arcane?
      when "divine"
        return character.can_divine?
      when "size"
        return character.racial_size.upcase == @value.upcase
      end
    rescue Exception => e
      #ap "Exception: "
      #ap e
      #ap "Self:"
      #ap self
      return false
    end
  end
end
