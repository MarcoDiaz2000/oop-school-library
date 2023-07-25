require_relative 'student'
require_relative 'teacher'
require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'
require_relative 'operations.rb'

def main
  people = []
  books = []

  loop do
    puts "Please, select an option:"
    puts "1. List all books"
    puts "2. List all people"
    puts "3. Create a person"
    puts "4. Create a book"
    puts "5. Create a rental"
    puts "6. List all rentals for a given person id"
    puts "7. Exit"

    selection = gets.chomp.to_i

    case selection
    when 1
      list_books(books)
    when 2
      list_people(people)
    when 3
      create_person(people)
    when 4
      create_book(books)
    when 5
      create_rental(books, people)
    when 6
      list_rentals_for_person_id(people)
    when 7
      puts "Goodbye!"
      break
    else
      puts "Invalid selection. Please choose a valid option."
    end
  end
end

main
