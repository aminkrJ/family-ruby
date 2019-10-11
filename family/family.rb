module Family
  class Family
    attr_accessor :husband, :wife, :sons, :daughters

    def initialize(sons: Collection.new, daughters: Collection.new, husband: nil, wife: nil)
      @sons = sons
      @daughters = daughters
      @husband = husband
      @wife = wife
    end

    def add_son(son)
      sons.add(son)
    end

    def add_daughter(daughter)
      daughters.add(daughter)
    end

    def children
      sons.merge!(daughters)
    end
  end
end

