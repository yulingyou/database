require_relative 'database_connection'
require_relative 'book'

class BookRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, author_name FROM books;

    # Returns an array of Book objects.
    sql_code = "SELECT id, title, author_name FROM books;"
    result = DatabaseConnection.exec_params(sql_code, [])
    return extract_books(result)
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, author_name FROM books WHERE id = #{id};
    # Returns a single Book object.
    sql_code = "SELECT id, title, author_name FROM books WHERE id = #{id};"
    result = DatabaseConnection.exec_params(sql_code, [])

    return extract_books(result).first
  end

  private

  def extract_books(query_result)
    books = []
    query_result.each do |record|
      book = Book.new
      book.id = record["id"]
      book.title = record["title"]
      book.author_name = record["author_name"]
      books << book
    end
    return books
  end

end