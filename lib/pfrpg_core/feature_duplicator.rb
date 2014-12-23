class PfrpgCore::FeatureDuplicator

  def self.dupe_words
    ['Sneak Attack', 'Channel Energy', 'Damage Reduction', 'Trap Sense']
  end

  # filter things with multiple bonuses, like sneak attack and channel energy
  def self.filter_duplicates(features)
    dupe_words.each do |w|
      features = features - smallest(features, w)
    end
    features
  end

  def self.smallest(features, phrase)
    smallest = features.select { |x| x.name[phrase] != nil }
    return [] if (smallest.empty? || smallest.size == 1)
    smallest.sort_by! { |x| parse_number(x.name) }
    smallest[0..smallest.size-2]
  end

  # of the form, 'Sneak Attack (10d6)'
  def self.parse_number(description)
    (description.split('d6')[0].split(' ').last.split('(')[1]).to_i
  end
end
