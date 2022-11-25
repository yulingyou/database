require_relative 'album'
class AlbumRepository

  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Album objects.
    sql_code = "SELECT id, title, release_year, artist_id FROM albums;"
    result = DatabaseConnection.exec_params(sql_code,[])
    return make_album(result)
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  # def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;

    # Returns a single Album object.
  #   sql_code = "SELECT id, title, release_year, artist_id FROM albums WHERE id = #{id};"
  #   result = DatabaseConnection.exec_params(sql_code,[])
  #   return make_album(result).first
  # end

  def find(id)
    sql = "SELECT * FROM albums WHERE id =$1 "
    result_set = DatabaseConnection.exec_params(sql,[id])

    record = result_set[0]

    album = Album.new

    album.id = record["id"]
    album.title = record["title"]
    album.release_year = record["release_year"]
    album.artist_id = record["artist_id"]

    return album

  end

  def create(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES($1, $2, $3);'
    sql_params = [album.title, album.release_year, album.artist_id]

    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM albums WHERE ID = $1;'
    #Doesn't need to return anything(only deletes the record)
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil 
  
  end

  def update(album)
    sql = 'UPDATE albums SET title = $1, release_year = $2, artist_id = $3 WHERE id = $4;'
    sql_params = [album.title, album.release_year, album.artist_id, album.id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil

  end
  
  private

  def make_album(query)
    albums = []
    query.each do |record|
      album = Album.new
      album.id = record["id"]
      album.title = record["title"]
      album.release_year = record["release_year"]
      album.artist_id = record["artist_id"]
      albums << album
    end
    return albums
  end

end