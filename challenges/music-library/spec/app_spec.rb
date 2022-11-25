require_relative '../app'
require 'database_connection'

def reset_table
  seed_sql = File.read('spec/seeds.sql')
  if ENV['PG_password']
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test', password: ENV['PG_password']})
  else
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
  end
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_table
  end

  it "runs command line musci library manager and ask for albums" do 
    io_double = double :fake_io
    expect(io_double).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(io_double).to receive(:puts).with("What would you like to do?").ordered
    expect(io_double).to receive(:puts).with("1 - List all albums").ordered
    expect(io_double).to receive(:puts).with("2 - List all artists").ordered
    expect(io_double).to receive(:puts).with("Enter your choice: ").ordered
    expect(io_double).to receive(:gets).and_return("1").ordered
    expect(io_double).to receive(:puts).with("Here is the list of albums:").ordered
    expect(io_double).to receive(:puts).with(" * 1 - Doolittle").ordered
    expect(io_double).to receive(:puts).with(" * 2 - Surfer Rosa").ordered
    expect(io_double).to receive(:puts).with(" * 3 - Super Trouper").ordered
    expect(io_double).to receive(:puts).with(" * 4 - Bossanova").ordered

    album_repo_double = double :fake_album_repo
    expect(album_repo_double).to receive(:all).and_return([
      double(:fake_album, id: 1, title: "Doolittle"),
      double(:fake_album, id: 2, title: "Surfer Rosa"),
      double(:fake_album, id: 3, title: "Super Trouper"),
      double(:fake_album, id: 4, title: "Bossanova"),
    ])
    artist_repo_double = double :fake_artist_repo
    app = Application.new(
      "music_library_test",
      io_double,
      album_repo_double,
      artist_repo_double
    )
    app.run
  end

  it "runs command line musci library manager and ask for artists" do 
    io_double = double :fake_io
    expect(io_double).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(io_double).to receive(:puts).with("What would you like to do?").ordered
    expect(io_double).to receive(:puts).with("1 - List all albums").ordered
    expect(io_double).to receive(:puts).with("2 - List all artists").ordered
    expect(io_double).to receive(:puts).with("Enter your choice: ").ordered
    expect(io_double).to receive(:gets).and_return("2").ordered
    expect(io_double).to receive(:puts).with("Here is the list of artists:").ordered
    expect(io_double).to receive(:puts).with(" * 1 - Pixies").ordered
    expect(io_double).to receive(:puts).with(" * 2 - ABBA").ordered

    artist_repo_double = double :fake_artist_repo
    expect(artist_repo_double).to receive(:all).and_return([
      double(:fake_artist, id: 1, name: "Pixies"),
      double(:fake_artist, id: 2, name: "ABBA"),
    ])
    album_repo_double = double :fake_album_repo
    app = Application.new(
      "music_library_test",
      io_double,
      album_repo_double,
      artist_repo_double
    )
    app.run
  end
end