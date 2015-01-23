class Stylist

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
  end

  define_singleton_method(:all) do
    all_stylists = []
    db_stylists = DB.exec("SELECT * FROM stylists ORDER BY name;")
    db_stylists.each() do |stylist|
      id = stylist.fetch("id").to_i()
      name = stylist.fetch("name")
      all_stylists.push(Stylist.new({:id => id, :name => name}))
    end
    all_stylists
  end

  define_method(:==) do |other_stylist|
    self.name() == other_stylist.name() && self.id() == other_stylist.id()
  end

  define_method(:save) do
    returned_id = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = returned_id.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |stylist_id|
    found_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist_id == stylist.id()
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM stylists *")
  end

  define_method(:get_client_ids) do
    assigned_client_ids = []
    returned_clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{@id};")
    returned_clients.each() do |client|
      id = client.fetch("id").to_i()
      assigned_client_ids.push(id)
    end
    assigned_client_ids
  end

end
