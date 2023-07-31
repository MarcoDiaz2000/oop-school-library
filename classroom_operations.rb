class ClassroomOperations
  attr_reader :classrooms

  def initialize(classrooms = [])
    @classrooms = classrooms
  end

  def find_or_create_by_label(label)
    classroom = @classrooms.find { |c| c.label == label }
    if classroom.nil?
      classroom = Classroom.new(label)
      @classrooms << classroom
    end
    classroom
  end
end
