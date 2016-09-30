
module SuperGrouper
  class << self

    def group(things, hierarchy)
      if hierarchy.any?
        _recursively_group(things, hierarchy)
      else
        raise ArgumentError.new("Expected at least 1 item in grouping hierarchy")
      end
    end


    def _recursively_group(things, hierarchy)
      return things if hierarchy.empty?

      key = hierarchy.first
      groupings = things.group_by{|t| t[key]}

      retval = {}
      groupings.each do |k, v|
        next_hierarchy = hierarchy[1..-1]
        retval[k] = _recursively_group(v, next_hierarchy)
      end

      retval
    end
  end
end

