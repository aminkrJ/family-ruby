$: << File.dirname(__FILE__)

require 'family/family'
require 'family/member'
require 'family/collection'
require 'family/facade'
require 'family/sentinel'

api = Family::Facade.new

text = File.open('input.txt').read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  arr = line.split(" ")

  case arr[0]
  when "GET_RELATIONSHIP"
    api.get_relationship(arr[1], arr[2])
  when "ADD_CHILD"
    api.add_child(arr[1], arr[2], arr[3])
  when "ADD_SPOUSE"
    api.add_spouse(arr[1], arr[2], arr[3])
  end
end
