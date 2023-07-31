require 'json'
require_relative 'student'
require_relative 'teacher'
require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'
require_relative 'rental_operations'
require_relative 'person_operations'
require_relative 'book_operations'
require_relative 'classroom_operations'

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

  def initialize
    @book_operations = BookOperations.new
    @classroom_operations = ClassroomOperations.new
    @person_operations = PersonOperations.new(@classroom_operations)
    @rental_operations = RentalOperations.new(@book_operations, @person_operations)
  end

  def list_books
    @book_operations.list
  end

  def list_people
    @person_operations.list
  end

  def create_person
    @person_operations.create
  end

  def create_book
    @book_operations.create
  end

  def create_rental
    @rental_operations.create
  end

  def list_rentals_for_person_id
    @rental_operations.list_rentals_for_person_id
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
