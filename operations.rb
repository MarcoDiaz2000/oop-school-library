require_relative 'student'
require_relative 'teacher'
require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'

def list_books(books)
  books.each { |book| puts "#{book.title}: #{book.author}" }
end

def list_people(people)
  people.each do |person|
    if person.is_a?(Student)
      permission = person.parent_permission ? "Has parent's permission" : "Doesn't have parent's permission"
      puts "[Student] Id: #{person.id}, Name: #{person.name}, Age #{person.age}, #{permission}"
    elsif person.is_a?(Teacher)
      puts "[Teacher] Id: #{person.id}, Name: #{person.name}, Age #{person.age}, Specialization: #{person.specialization}"
    end
  end
end

def create_person(people)
  puts "Do you want to create a student (1) or a teacher (2)? [Input number]"
  type = gets.chomp.to_i

  puts "Enter the name:"
  name = gets.chomp

  puts "Enter the age:"
  age = gets.chomp.to_i

  if type == 1
    puts "Enter the classroom:"
    classroom_label = gets.chomp
    classroom = Classroom.new(classroom_label)
    
    puts "Has parent permission [Y/N]:"
    parent_permission = gets.chomp.downcase == 'y' ? true : false

    new_person = Student.new(age, classroom, name: name, parent_permission: parent_permission)
  elsif type == 2
    puts "Enter the specialization:"
    specialization = gets.chomp

    new_person = Teacher.new(age, specialization, name: name)
  else
    puts "Invalid option, try again."
    create_person(people)
    return
  end

  people << new_person
  puts "Person created successfully"
end

def create_book(books)
  puts "Enter the title:"
  title = gets.chomp
  puts "Enter the author:"
  author = gets.chomp
  new_book = Book.new(title, author)
  books << new_book
  puts "Book created successfully"
end

def create_rental(books, people)
  puts "Select a book from the following list by number"
  books.each_with_index { |book, index| puts "#{index}) #{book.title}" }
  book_index = gets.chomp.to_i

  puts "Select a person from the following list by number"
  people.each_with_index { |person, index| puts "#{index}) #{person.name}" }
  person_index = gets.chomp.to_i

  puts "Enter the date in format 'YYYY-MM-DD':"
  date = gets.chomp

  new_rental = Rental.new(date, books[book_index], people[person_index])

  puts "Rental created successfully"
end

def list_rentals_for_person_id(people)
  puts "Enter the person id:"
  id = gets.chomp.to_i

  person = people.find { |person| person.id == id }

  if person.nil?
    puts "No person found with id #{id}"
    return
  end

  person.rentals.each do |rental|
    puts "Date: #{rental.date}, #{rental.book.title} rented by #{rental.book.author}"
  end
end