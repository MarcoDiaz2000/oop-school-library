class BookOperations
  def initialize(books = [])
    if File.exist?('books.json')
      books_data = File.read('books.json')
      @books = JSON.parse(books_data, create_additions: true)
    else
      @books = books
    end
  end

  def list
    @books.each { |book| puts "#{book.title}: #{book.author}" }
  end

  def list_and_return
    @books.each_with_index { |book, index| puts "#{index}: #{book.title}, #{book.author}" }
    @books
  end

  def create
    puts 'Enter the title:'
    title = gets.chomp
    puts 'Enter the author:'
    author = gets.chomp
    new_book = Book.new(title, author)
    @books << new_book
    puts 'Book created successfully'
  end

  def find_by_id(id)
    @books.find { |book| book.id == id }
  end

  def save
    File.write('books.json', JSON.dump(@books))
  end
end
