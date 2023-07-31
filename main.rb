require_relative 'operations'
require_relative 'menu'

def main
  people = []
  books = []

  operations = LibraryOperations.new(books, people)

  loop do
    print_menu
    selection = gets.chomp.to_i
    operations.execute_option(selection)
  end
end

main
