require_relative 'student'
require_relative 'teacher'
require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'

class LibraryOperations
  ACTIONS = {
    1 => :list_books,
    2 => :list_people,
    3 => :create_person,
    4 => :create_book,
    5 => :create_rental,
    6 => :list_rentals_for_person_id,
    7 => :exit_program
  }.freeze

  def initialize(books, people)
    @books = books
    @people = people
  end

  # option 1
  def list_books
    @books.each { |book| puts "#{book.title}: #{book.author}" }
  end

  # option 2
  def list_people
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

  # option 3
  def ask_for_name_and_age
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

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input number]'
    type = gets.chomp.to_i

    name, age = ask_for_name_and_age

    if type == 1
      classroom, parent_permission = create_student
      new_person = Student.new(age, classroom, name: name, parent_permission: parent_permission)
    elsif type == 2
      specialization = create_teacher
      new_person = Teacher.new(age, specialization, name: name)
    else
      puts 'Invalid option, try again.'
      create_person
      return
    end

    @people << new_person
    puts 'Person created successfully'
  end

  # option 4
  def create_book
    puts 'Enter the title:'
    title = gets.chomp
    puts 'Enter the author:'
    author = gets.chomp
    new_book = Book.new(title, author)
    @books << new_book
    puts 'Book created successfully'
  end

  # option 5
  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) #{book.title}" }
    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number'
    @people.each_with_index { |person, index| puts "#{index}) #{person.name}" }
    person_index = gets.chomp.to_i

    puts "Enter the date in format 'YYYY-MM-DD':"
    date = gets.chomp

    Rental.new(date, @books[book_index], @people[person_index])

    puts 'Rental created successfully'
  end

  # option 6
  def list_rentals_for_person_id
    puts 'Enter the person id:'
    id = gets.chomp.to_i

    person = @people.find { |p| p.id == id }

    if person.nil?
      puts "No person found with id #{id}"
      return
    end

    person.rentals.each do |rental|
      puts "Date: #{rental.date}, #{rental.book.title} rented by #{person.name}"
    end
  end

  def exit_program
    puts 'Goodbye!'
    exit
  end

  def execute_option(option)
    if ACTIONS.key?(option)
      send(ACTIONS[option])
    else
      puts 'Invalid selection. Please choose a valid option.'
    end
  end
end
