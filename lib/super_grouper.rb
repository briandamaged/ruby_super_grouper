
module SuperGrouper
  class << self

    # Returns a lambda that will retrieve the specified key
    def key_retriever_for(key)
      ->(thing) { thing[key] }
    end


    def coerce_extractors(extractors)
      extractors.map do |x|
        if x.respond_to? :call
          x
        else
          key_retriever_for(x)
        end
      end
    end

    def group(things, extractors)
      if extractors.any?
        _recursively_group(things, coerce_extractors(extractors))
      else
        raise ArgumentError.new("Expected at least 1 item in grouping extractors")
      end
    end


    def _recursively_group(things, extractors)
      return things if extractors.empty?

      x = extractors.first
      groupings = things.group_by(&x)

      retval = {}
      groupings.each do |k, v|
        next_extractors = extractors[1..-1]
        retval[k] = _recursively_group(v, next_extractors)
      end

      retval
    end
  end
end

