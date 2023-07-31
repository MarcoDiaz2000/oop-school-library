require_relative 'person'
require 'json'

class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, name: 'Unknown')
    super(age, name: name, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'id' => @id,
      'age' => @age,
      'name' => @name,
      'specialization' => @specialization
    }.to_json(*args)
  end

  def self.json_create(object)
    teacher = new(object['age'], object['specialization'], name: object['name'])
    teacher.instance_variable_set(:@id, object['id'])
    teacher
  end
end
