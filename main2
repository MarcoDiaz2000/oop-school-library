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

def menu_actions(books, people)
  {
    1 => -> { list_books(books) },
    2 => -> { list_people(people) },
    3 => -> { create_person(people) },
    4 => -> { create_book(books) },
    5 => -> { create_rental(books, people) },
    6 => -> { list_rentals_for_person_id(people) },
    7 => lambda {
      puts 'Goodbye!'
      exit
    }
  }
end

def menu_option(selection, books, people)
  if menu_actions(books, people)[selection]
    menu_actions(books, people)[selection].call
  else
    puts 'Invalid selection. Please choose a valid option.'
  end
end

def main
  people = []
  books = []

  loop do
    print_menu
    selection = gets.chomp.to_i
    menu_option(selection, books, people)
  end
end

main
