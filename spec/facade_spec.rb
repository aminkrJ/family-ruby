require 'spec_helper'

describe Family::Facade do
  it "adds a child" do
    storage = double
    mother_name = "mother_name"
    child_name = "child_name"
    gender = "Male"
    storage.should_receive(:find).with(mother_name)
    storage.should_receive(:add).twice
    subject.storage = storage
    subject.add_child(mother_name, child_name, gender)
  end
end
