class RentalOperations
  def initialize(book_operations, person_operations, rentals = [])
    @book_operations = book_operations
    @person_operations = person_operations
    @rentals = rentals
  end

  def create
    puts 'Select a book from the following list by number'
    books = @book_operations.list_and_return
    book = books[gets.chomp.to_i]

    puts 'Select a person from the following list by number'
    people = @person_operations.list_and_return
    person = people[gets.chomp.to_i]

    puts 'Date:'
    date = gets.chomp

    rental = Rental.new(date, book, person)

    @rentals << rental
  end

  def list_rentals_for_person_id
    puts 'ID of person:'
    id = gets.chomp.to_i
    person = @person_operations.find_by_id(id)

    if person.nil?
      puts "No se pudo encontrar a una persona para el ID #{id}. Por favor, proporciona un ID válido."
      return
    end

    puts "Rentals for person #{person.name}:"
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title}"
    end
  end
end
