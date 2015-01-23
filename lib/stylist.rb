class Stylist

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
  end

  define_singleton_method(:all) do
    all_stylists = []
    db_stylists = DB.exec("SELECT * FROM stylists")
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


end