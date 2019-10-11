module Family
  class Member
    attr_accessor :gender, :name, :family, :parent, :sentinel

    MALE = "Male"
    FEMALE = "Female"

    def initialize(gender:, name: nil, parent: nil, family: nil, sentinel: Sentinel)
      @gender = gender
      @name = name
      @parent = parent
      @family = family
      @sentinel = sentinel
    end

    def self.build_female(name: nil, parent: nil, family: nil, sentinel: nil)
      Member.new(gender: FEMALE, name: name, parent: parent, family: family, sentinel: sentinel)
    end

    def self.build_male(name: nil, parent: nil, family: nil, sentinel: nil)
      Member.new(gender: MALE, name: name, parent: parent, family: family, sentinel: sentinel)
    end

    def add_spouse(gender, name)
      spouse = Member.new(gender: gender, name: name, parent: sentinel.build, family: self.family)

      if spouse.male?
        family.wife = self
        family.husband = spouse
      else
        family.wife = spouse
        family.husband = self
      end

      spouse
    end

    def add_child(gender, name)
      child = Member.new(gender: gender, name: name, parent: self.family, family: sentinel.build)

      if child.male?
        family.add_son(child)
      else
        family.add_daughter(child)
      end

      child
    end

    def female?
      gender == FEMALE
    end

    def male?
      gender == MALE
    end

    def daughters
      family.daughters
    end

    def spouse
      male? ?
        family.wife :
        family.husband
    end

    def wife
      family.wife
    end

    def husband
      family.husband
    end

    def sons
      family.sons
    end

    def siblings
      parent.children
    end

    def sisters
      parent.daughters
    end

    def brothers
      parent.sons
    end

    def paternal_uncle
      parent.husband.brothers.except(parent.husband)
    end

    def maternal_uncle
      parent.wife.brothers.except(parent.wife)
    end

    def paternal_aunt
      parent.husband.sisters.except(parent.husband)
    end

    def maternal_aunt
      parent.wife.sisters.except(parent.wife)
    end

    def spouse_sisters
      spouse.sisters.except(spouse)
    end

    def spouse_brothers
      spouse.brothers.except(spouse)
    end

    def sibilings_wives
      brothers.map(&:wife)
    end

    def sibilings_husbands
      sisters.map(&:husband)
    end

    def married?
      !!spouse.name
    end

    def sisters_in_law
      if married?
        spouse_sisters.merge! sibilings_wives
      else
        sibilings_wives
      end
    end

    def brothers_in_law
      if married?
        spouse_brothers.merge! sibilings_husbands
      else
        sibilings_wives
      end
    end
  end
end
