class PersonOperations
  def initialize(classroom_operations, people = [])
    if File.exist?('people.json')
      people_data = File.read('people.json')
      @people = JSON.parse(people_data, create_additions: true)
    else
      @people = people
    end
    @classroom_operations = classroom_operations
  end

  def find_by_id(id)
    @people.find { |person| person.id == id }
  end

  def save
    File.write('people.json', JSON.dump(@people))
  end

  def list
    @people.each do |person|
      if person.is_a?(Student)
        permission = person.parent_permission ? "Has parent's permission" : "Doesn't have parent's permission"
        puts "[Student] Id: #{person.id}, Name: #{person.name}, Age #{person.age}, #{permission}"
      elsif person.is_a?(Teacher)
        puts "[Teacher] Id: #{person.id}, Name: #{person.name}, Age #{person.age}, " \
             "Specialization: #{person.specialization}"
      end
    end
  end

  def create
    puts 'Do you want to create a student (1) or a teacher (2)?'
    selection = gets.chomp.to_i

    case selection
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid option'
    end
  end

  def list_and_return
    @people.each_with_index { |person, index| puts "#{index}: #{person.name}, #{person.age}" }
    @people
  end

  private

  def create_student
    puts 'Age:'
    age = gets.chomp.to_i
    puts 'Name:'
    name = gets.chomp
    puts 'Has parent permission? [Y/N]:'
    parent_permission = gets.chomp.downcase == 'y'
    puts 'Classroom:'
    classroom_label = gets.chomp
    classroom = @classroom_operations.find_or_create_by_label(classroom_label)

    student = Student.new(age, classroom, name: name, parent_permission: parent_permission)
    @people << student
  end

  def create_teacher
    puts 'Age:'
    age = gets.chomp.to_i
    puts 'Name:'
    name = gets.chomp
    puts 'Specialization:'
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name: name)
    @people << teacher
  end
end
