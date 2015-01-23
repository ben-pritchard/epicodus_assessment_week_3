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
  @stylist = Sylist.find(stylist_id)
  erb(:stylist_info)
end
