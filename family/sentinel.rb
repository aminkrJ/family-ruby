module Family
  class Sentinel < Family
    def self.build
      Family.new(sons: Collection.new, daughters: Collection.new, wife: Member.build_male, husband: Member.build_female)
    end
  end
end
