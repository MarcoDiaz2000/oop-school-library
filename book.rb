class Book
  attr_accessor :title, :author, :rentals
  attr_reader :id

  @book_count = 0
  @book_instances = []

  class << self
    attr_accessor :book_count, :book_instances
  end

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
    self.class.book_count += 1
    @id = self.class.book_count
    self.class.book_instances << self
  end

  def self.find_by_id(id)
    book_instances.find { |book| book.id == id }
  end

  def add_rental(person, date)
    Rental.new(date, self, person)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'id' => @id,
      'title' => @title,
      'author' => @author
    }.to_json(*args)
  end

  def self.json_create(object)
    book = new(object['title'], object['author'])
    book.instance_variable_set(:@id, object['id'])
    book
  end
end
