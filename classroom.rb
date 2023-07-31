class Classroom
  attr_accessor :label
  attr_reader :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    @students << student
    student.classroom = self
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'label' => @label
    }.to_json(*args)
  end

  def self.json_create(object)
    new(object['label'])
  end

  def self.find_by_label(label)
    ClassroomOperations.new.classrooms.find { |classroom| classroom.label == label }
  end
end
