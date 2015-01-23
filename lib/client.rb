class Client

  attr_reader(:id, :name, :stylist_id)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
    @stylist_id = attributes[:stylist_id]
  end

  define_singleton_method(:all) do
    all_clients = []
    db_clients = DB.exec("SELECT * FROM clients")
    db_clients.each() do |client|
      id = client.fetch("id").to_i()
      name = client.fetch("name")
      stylist_id = client.fetch("stylist_id")
      all_clients.push(Client.new({:id => id, :name => name, :stylist_id => stylist_id}))
    end
    all_clients
  end

  define_method(:==) do |other_client|
    self.name() == other_client.name() && self.id() == other_client.id()
  end

  define_method(:save) do
    returned_id = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', #{@stylist_id}) RETURNING id;")
    @id = returned_id.first().fetch("id").to_i()
  end

  

end