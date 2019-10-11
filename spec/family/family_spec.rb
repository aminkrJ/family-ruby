require 'spec_helper'

describe Family::Family do
  it "add_son" do
    son = double
    sons = double
    sons.should_receive(:add).with(son)
    subject.sons = sons
    subject.add_son(son)
  end

  it "add_daughter" do
    daughter = double
    daughters = double
    daughters.should_receive(:add).with(daughter)
    subject.daughters = daughters
    subject.add_daughter(daughter)
  end

  it "children" do
    daughters = double
    sons = double
    subject.daughters = daughters
    subject.sons = sons
    sons.should_receive(:merge!).with(daughters)
    subject.children
  end
end
