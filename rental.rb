require 'json'

class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person

    book.rentals << self unless book.rentals.include?(self)
    person.rentals << self unless person.rentals.include?(self)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'date' => @date,
      'book_id' => @book.id,
      'person_id' => @person.id
    }.to_json(*args)
  end

  def self.json_create(object)
    book = Book.find_by_id(object['book_id'])
    person = Person.find_by_id(object['person_id'])
    new(object['date'], book, person)
  end
end
