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

post("/clear") do
  Stylist.clear()
  redirect("/stylists")
end
