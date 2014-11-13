class PfrpgCore::Prerequisite::ClassPrereq < PfrpgCore::Prerequisite
  def match(character)
    begin
      hc = PfrpgClasses::Heroclass.by_name(@attribute)
      base = character.get_class_level(hc)
      base += character.get_class_level('Eldritch Knight') if @attribute == 'Fighter'
      return base >= value
    rescue Exception
      return false
    end
  end
end
