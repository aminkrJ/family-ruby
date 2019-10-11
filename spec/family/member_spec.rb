require 'spec_helper'

describe Family::Member do
  subject { Family::Member.new(gender: "Female") }
  let(:name) { "name" }
  let(:female_gender) { "Female" }
  let(:male_gender) { "Male" }

  it ".build_male" do
    male = Family::Member.build_male
    expect(male).to be_a_kind_of Family::Member
    expect(male.gender).to  male_gender
  end

  it "paternal_uncle" do
    parent = double
    parent.stub_chain(:husband, :brothers, :except).with(parent.husband)
    subject.parent = parent
    subject.paternal_uncle
  end

  describe "add_spouse" do
    it "adds a wife" do
      family = double
      family.should_receive(:wife=)
      family.should_receive(:husband=)
      subject.family = family
      spouse = subject.add_spouse(female_gender, name)
      expect(spouse.gender).to eq(female_gender)
      expect(spouse.name).to eq(name)
    end

    it "adds a husband" do
      family = double
      family.should_receive(:wife=)
      family.should_receive(:husband=)
      subject.family = family
      spouse = subject.add_spouse(male_gender, name)
      expect(spouse.gender).to eq(male_gender)
      expect(spouse.name).to eq(name)
    end
  end

  it "wife" do
    family = double
    family.should_receive(:wife)
    subject.family = family
    subject.wife
  end

  it "husband" do
    family = double
    family.should_receive(:husband)
    subject.family = family
    subject.husband
  end

  describe "add_child" do
    it "adds a son" do
      family = double
      subject.family = family
      family.should_receive(:add_son)
      child = subject.add_child(male_gender, name)
      expect(child).to be_a_kind_of Family::Member
      expect(child.gender).to eq(male_gender)
      expect(child.name).to eq(name)
    end

    it "adds a daughter" do
      family = double
      subject.family = family
      family.should_receive(:add_daughter)
      child = subject.add_child(female_gender, name)
      expect(child).to be_a_kind_of Family::Member
      expect(child.gender).to eq(female_gender)
      expect(child.name).to eq(name)
    end
  end
end

