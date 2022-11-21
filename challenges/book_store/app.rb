require_relative 'lib/book_repository'

DatabaseConnection.connect("book_store")
repo = BookRepository.new
books = repo.all

books.each do |book|
  puts "#{book.id} - #{book.title} - #{book.author_name}"
end