require_relative 'person'

class Student < Person
  def initialize(age, classroom, name: 'Unknown', parent_permission: true)
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\\_(ツ)_/¯'
  end
end

student1 = Student.new(15, 'Classroom A', parent_permission: false)

puts student1.inspect
