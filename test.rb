require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'decorator'

# Decorator tests
person = Person.new(22, name: 'maximilianus')
puts person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name

# New tests for Person, Book, and Rental relationships
pepe = Person.new(30, name: 'Pepe')
book1 = Book.new('1984', 'George Orwell')
rental1 = Rental.new('2023-10-01', book1, pepe)

puts pepe.inspect
puts book1.inspect
puts rental1.inspect
