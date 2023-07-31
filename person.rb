require_relative 'nameable'

class Person < Nameable
  attr_reader :id, :rentals, :parent_permission
  attr_accessor :name, :age

  class << self
    attr_accessor :person_instances
  end

  def initialize(age, name: 'Unknown', parent_permission: true)
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    (self.class.person_instances ||= []) << self
    super()
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(book, date)
    Rental.new(date, book, self)
  end

  def self.find_by_id(id)
    person_instances.find { |person| person.id == id }
  end

  private

  def of_age?
    @age >= 18
  end

  def generate_id
    if File.exist?('last_id.txt')
      last_id = File.read('last_id.txt').to_i
      new_id = last_id + 1
    else
      new_id = 1
    end
    File.write('last_id.txt', new_id.to_s)
    new_id
  end
end
