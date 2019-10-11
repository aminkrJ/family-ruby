module Family
  class Facade
    attr_accessor :sentinel, :storage

    def initialize(storage: Collection.new, sentinel: Sentinel)
      @storage = storage
      @sentinel = sentinel
    end

    def add_child(name, child_name, gender)
      mother = storage.find(name) || Member.build_female(name: name, parent: sentinel.build, family: sentinel.build, sentinel: sentinel)

      if mother.male?
        puts "CHILD_ADDITION_FAILED"
        return
      end

      child = mother.add_child(gender, child_name)

      storage.add(mother)
      storage.add(child)

      puts "CHILD_ADDITION_SUCCEEDED"
    end

    def add_spouse(name, spouse_name, gender)
      member = storage.find(name)

      spouse = member.add_spouse(gender, spouse_name)

      storage.add(spouse)
    end

    def get_relationship(name, relationship)
      member = storage.find(name)

      unless member
        puts "PERSON_NOT_FOUND";
        return;
      end

      collection = case relationship
        when "Paternal-Uncle"
          member.paternal_uncle
        when "Maternal-Uncle"
          member.maternal_uncle
        when "Paternal-Aunt"
          member.paternal_aunt
        when "Maternal-Aunt"
          member.paternal_aunt
        when "Sister-In-Law"
          member.sisters_in_law
        when "Brother-In-Law"
          member.brothers_in_law
        when "Son"
          member.sons
        when "Daughter"
          member.daughters
        when "Siblings"
          member.siblings
      end

      arr = collection.except(member).to_arr
      if arr.empty?
        puts "NONE"
      else
        puts arr.map(&:name).join(" ")
      end
    end
  end
end
