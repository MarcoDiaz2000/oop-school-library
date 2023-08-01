class ClassroomOperations
  attr_reader :classrooms

  def initialize(classrooms = [])
    if File.exist?('classrooms.json')
      classrooms_data = File.read('classrooms.json')
      @classrooms = JSON.parse(classrooms_data, create_additions: true)
    else
      @classrooms = classrooms
    end
  end

  def find_or_create_by_label(label)
    classroom = @classrooms.find { |c| c.label == label }
    if classroom.nil?
      classroom = Classroom.new(label)
      @classrooms << classroom
    end
    classroom
  end

  def save
    File.write('classrooms.json', JSON.dump(@classrooms))
  end
end
