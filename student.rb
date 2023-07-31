require_relative 'person'
require 'json'

class Student < Person
  attr_reader :classroom, :parent_permission

  def initialize(age, classroom, name: 'Unknown', parent_permission: true)
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.add_student(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\\_(ツ)_/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self) unless classroom.students.include?(self)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'id' => @id,
      'age' => @age,
      'classroom' => @classroom.label,
      'name' => @name,
      'parent_permission' => @parent_permission
    }.to_json(*args)
  end

  def self.json_create(object)
    classroom = Classroom.find_by_label(object['classroom'])
    student = new(object['age'], classroom, name: object['name'], parent_permission: object['parent_permission'])
    student.instance_variable_set(:@id, object['id'])
    student
  end
end
