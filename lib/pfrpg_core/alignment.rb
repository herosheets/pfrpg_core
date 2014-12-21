module PfrpgCore
  class Alignment

    attr_reader :alignment
    def initialize(alignment)
      @alignment = PfrpgCore::Alignment.parse(alignment)
    end

    def self.filter_by_character(character)
      alignments = []
      first_class = character.get_last_level.heroclass
      classed = get_alignments_for_class(first_class)
      any.each do |alignment|
        alignments << alignment if classed.include?(alignment)
      end
      return alignments
    end

    def self.get_alignments_for_class(heroclass)
      heroclass.alignment
    end

    def self.parse(alignment_str)
      return "None" unless alignment_str
      if alignment_str.length == 2
        h = {
            'CN' => "Chaotic Neutral",
            'CE' => "Chaotic Evil",
            'CG' => "Chaotic Good",
            'NE' => "Neutral Evil",
            "TN" => "True Neutral",
            "NG" => "Neutral Good",
            "LE" => "Lawful Evil",
            "LG" => "Lawful Good",
            "LN" => "Lawful Neutral"
        }
        return h[alignment_str] || "None"
      else
        return alignment_str
      end
    end

    def self.any
      ["Chaotic Evil", "Chaotic Neutral", "Chaotic Good",
       "Neutral Evil", "True Neutral", "Neutral Good",
       "Lawful Evil", "Lawful Neutral", "Lawful Good" ]
    end

    def self.never_lawful
      ["Chaotic Evil", "Chaotic Neutral", "Chaotic Good",
       "Neutral Evil", "True Neutral", "Neutral Good" ]
    end

    def self.any_evil
      ["Chaotic Evil", "Neutral Evil", "Lawful Evil"]
    end

    def self.any_neutral
      ["Neutral Good", "Neutral Evil", "True Neutral"]
    end

    def self.any_lawful
      ["Lawful Good", "Lawful Evil", "Lawful Neutral"]
    end

    def self.from_str(alignment_str)
      any.find { |x| x.downcase == alignment_str.downcase }
    end

    def self.from_deity_str(str)
      case str
        when "CE"
          from_str('Chaotic Evil')
        when "CN"
          from_str('Chaotic Neutral')
        when "CG"
          from_str('Chaotic Good')
        when "NE"
          from_str('Neutral Evil')
        when "NE"
          from_str('True Neutral')
        when "NG"
          from_str('Neutral Good')
        when "LE"
          from_str('Lawful Evil')
        when "LN"
          from_str('Lawful Neutral')
        when "LG"
          from_str('Lawful Good')
      end
    end

  end
end