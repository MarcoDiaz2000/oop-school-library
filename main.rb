require_relative 'student'
require_relative 'teacher'
require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'
require_relative 'operations'

def print_menu
  puts 'Please, select an option:'
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List all rentals for a given person id'
  puts '7. Exit'
end

def menu_options(selection, books, people)
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
  else
    puts 'Invalid selection. Please choose a valid option.'
  end
end

def exit_program(selection)
  return unless selection == 7

  puts 'Goodbye!'
  exit
end

def main
  people = []
  books = []

  loop do
    print_menu
    selection = gets.chomp.to_i
    exit_program(selection)
    menu_options(selection, books, people)
  end
end

main
