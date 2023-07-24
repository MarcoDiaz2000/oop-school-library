require_relative 'person'

class Teacher < Person
  def initialize(age, specialization, name: 'Unknown')
    super(age, name: name, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

teacher1 = Teacher.new(15, 'Civic', name: 'Juan')

puts teacher1.inspect
