require("sinatra")
require("sinatra/reloader")
also_reload("./lib/**/*.rb")
require("./lib/stylist")
require("./lib/client")
require("pry")
require("pg")

DB = PG.connect({:dbname => 'hair_salon'})

get("/") do
  erb(:index)
end

get("/stylists") do
  @stylists = Stylist.all()
  erb(:stylists)
end

get("/stylist/:stylist_id") do
  stylist_id = params.fetch("stylist_id").to_i()
  @stylist = Stylist.find(stylist_id)
  @assigned_client_ids = @stylist.get_client_ids()
  erb(:stylist_info)
end

post("/add_stylist") do
  stylist_name = params.fetch("stylist_name")
  new_stylist = Stylist.new({:name => stylist_name})
  new_stylist.save()
  redirect("/stylists")
end

post("/add_client_to_stylist") do
  client_name = params.fetch("client_name")
  @client = Client.new({:name => client_name})
  @client.save()
  @stylist_id = params.fetch("stylist_id").to_i()
  @stylist = Stylist.find(@stylist_id)
  @client.assign(@stylist)
  @assigned_client_ids = @stylist.get_client_ids()
  erb(:stylist_info)
end

post("/clear_stylists") do
  Stylist.clear()
  redirect("/stylists")
end


get("/clients") do
  @clients = Client.all()
  erb(:clients)
end

get("/client/:client_id") do
  client_id = params.fetch("client_id").to_i()
  @client = Client.find(client_id)
  @assigned_stylist_id = @client.get_stylist_id()
  erb(:client_info)
end

post("/add_client") do
  client_name = params.fetch("client_name")
  new_client = Client.new({:name => client_name})
  new_client.save()
  redirect("/clients")
end

post("/add_stylist_to_client") do
  stylist_name = params.fetch("stylist_name")
  @stylist = Stylist.new({:name => stylist_name})
  @stylist.save()
  @client_id = params.fetch("client_id").to_i()
  @client = Client.find(@client_id)
  @stylist.assign(@client)
  @assigned_stylist_id = @client.get_stylist_id()
  erb(:client_info)
end

post("/clear_clients") do
  Client.clear()
  redirect("/clients")
end
