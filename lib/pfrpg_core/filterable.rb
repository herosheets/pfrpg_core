module PfrpgCore::Filterable
  def apply_filters
    @filters.each do |f|
      begin
        self.filter_str << "Filtering #{f.class}"
        f.filter(self)
      rescue Exception
      end
    end
  end
end
