require_relative "lib/database_connection"
require_relative "lib/album_repository"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform an SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM albums ORDER BY id;'
# result = DatabaseConnection.exec_params(sql, [])
album_repository = AlbumRepository.new

#Get the album with id 3
album = album_repository.find(3)

puts album.id
puts album.title
puts album.release_year
puts album.artist_id

# Print out each record from the result set.
# result.each do |record|
#   puts record
# end

# album_repository.all.each do |album|
#   p album
# end