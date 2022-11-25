require 'album_repository'

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  if ENV["PG_password"] 
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test', password: ENV["PG_password"] })
  else
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
  end
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  # (your tests will go here).
  it "all returns a list of albums" do
    repo = AlbumRepository.new

    albums = repo.all

    expect(albums.length).to eq 4

    expect(albums[0].id).to eq  "1"
    expect(albums[0].title).to eq 'Doolittle'
    expect(albums[0].release_year).to eq "1989"
    expect(albums[0].artist_id).to eq "1"

    expect(albums[1].id).to eq "2"
    expect(albums[1].title).to eq 'Surfer Rosa'
    expect(albums[1].release_year).to eq "1988"
    expect(albums[1].artist_id).to eq "1"
  end
  # 2
  # it " Find third albums" do

  #   repo = AlbumRepository.new

  #   album = repo.find(3)

  #   expect(album.id).to eq  "3"
  #   expect(album.title).to eq 'Super Trouper'
  #   expect(album.release_year).to eq  "1980"
  #   expect(album.artist_id).to eq "2"
  # end



  it "returns the album with id 3" do
  
    repo = AlbumRepository.new

    album = repo.find(3)
    expect(album.id).to eq "3"
    expect(album.title).to eq 'Super Trouper'
    expect(album.release_year).to eq "1980"
    expect(album.artist_id).to eq "2"

  end
  it "creates a new album" do
    repo = AlbumRepository.new
    album = Album.new
    album.title = "Album 01"
    album.release_year = "2022"

    repo.create(album)

    albums = repo.all
    last_album = albums.last

    expect(last_album.title).to eq ("Album 01")
    expect(last_album.release_year).to eq("2022")
  end

  it "deletes albums with id 1" do 
    repo = AlbumRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)

    all_albums = repo.all
    expect(all_albums.length).to eq 3
    expect(all_albums.first.id).to eq '2'

  end

  it "deletes albums two albums" do 
    repo = AlbumRepository.new

    repo.delete(1)
    repo.delete(2)

    all_albums = repo.all
    expect(all_albums.length).to eq 2
    expect(all_albums.first.id).to eq '3'

  end

  it "updates the album with new values " do 
    repo = AlbumRepository.new

    album = repo.find(1)

    album.title = 'Something else'
    album.release_year = '2022'
    album.artist_id = '3'

    repo.update(album)

    updated_album = repo.find(1)

    expect(updated_album.title).to eq 'Something else'
    expect(updated_album.release_year).to eq '2022'
    expect(updated_album.artist_id).to eq '3'

  end

  it "updates the album with only title " do 
    repo = AlbumRepository.new

    album = repo.find(1)

    album.title = 'Something else'

    repo.update(album)

    updated_album = repo.find(1)

    expect(updated_album.title).to eq 'Something else'
    expect(updated_album.release_year).to eq '1989'
    expect(updated_album.artist_id).to eq '1'

  end
end