require 'json'
require 'sqlite3'
configure do
  @@db = SQLite3::Database.new("unicorn.db")
end

get "/update" do
  '{"success":"true"}'
end
post "/register_name" do
  @@db.execute("INSERT INTO players(name) VALUES(?)", params[:name])

  player_list = @@db.execute("SELECT * FROM players")

  {:player_list => player_list}.to_json
end