require_relative 'student'
require_relative 'teacher'
require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'

def list_people(people)
  people.each do |individual|
    if individual.is_a?(Student)
      permission = individual.parent_permission ? "Has parent's permission" : "Doesn't have parent's permission"
      puts "[Student] Id: #{individual.id}, Name: #{individual.name}, Age #{individual.age}, #{permission}"
    elsif individual.is_a?(Teacher)
      puts "[Teacher] Id: #{individual.id}, Name: #{individual.name}, Age #{individual.age},
      Specialization: #{individual.specialization}"
    end
  end
end

def create_person_details
  puts 'Enter the name:'
  name = gets.chomp

  puts 'Enter the age:'
  age = gets.chomp.to_i

  [name, age]
end

def create_student
  puts 'Enter the classroom:'
  classroom_label = gets.chomp
  classroom = Classroom.new(classroom_label)

  puts 'Has parent permission [Y/N]:'
  parent_permission = gets.chomp.downcase == 'y'

  [classroom, parent_permission]
end

def create_teacher
  puts 'Enter the specialization:'
  gets.chomp
end

def create_person(people)
  puts 'Do you want to create a student (1) or a teacher (2)? [Input number]'
  type = gets.chomp.to_i

  name, age = create_person_details

  if type == 1
    classroom, parent_permission = create_student
    new_person = Student.new(age, classroom, name: name, parent_permission: parent_permission)
  elsif type == 2
    specialization = create_teacher
    new_person = Teacher.new(age, specialization, name: name)
  else
    puts 'Invalid option, try again.'
    create_person(people)
    return
  end

  people << new_person
  puts 'Person created successfully'
end

def list_rentals_for_person_id(people)
  puts 'Enter the person id:'
  id = gets.chomp.to_i

  person_found = people.find { |individual| individual.id == id }

  if person_found.nil?
    puts "No person found with id #{id}"
    return
  end

  person_found.rentals.each do |rental|
    puts "Date: #{rental.date}, #{rental.book.title} rented by #{rental.book.author}"
  end
end
