class Client

  attr_reader(:id, :name, :stylist_id)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
    @stylist_id = attributes[:stylist_id]
  end

  define_singleton_method(:all) do
    all_clients = []
    db_clients = DB.exec("SELECT * FROM clients ORDER BY name")
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
    returned_id = DB.exec("INSERT INTO clients (name) VALUES ('#{@name}') RETURNING id;")
    @id = returned_id.first().fetch("id").to_i()
  end

  define_method(:assign) do |stylist|
    @stylist_id = stylist.id()
    DB.exec("UPDATE clients SET stylist_id = #{@stylist_id} WHERE id = #{@id};")
  end

  define_singleton_method(:find) do |client_id|
    found_client = nil
    Client.all().each() do |client|
      if client_id == client.id()
        found_client = client
      end
    end
    found_client
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM clients *")
  end

  define_method(:get_stylist_id) do
    assigned_stylist_id = []
    if @stylist_id == nil
      assigned_stylist_id = [nil]
    else
      returned_stylist = DB.exec("SELECT * FROM stylists WHERE id = #{@stylist_id};")
      returned_stylist.each() do |stylist|
        id = stylist.fetch("id").to_i()
        assigned_stylist_id.push(id)
      end
    end
    assigned_stylist_id
  end

end
