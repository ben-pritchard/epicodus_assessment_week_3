require("spec_helper")

describe(Client) do
  describe(".all") do
    it("returns all of the clients in the database - should be empty at first") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe("#id") do
    it("returns the id of a client") do
      baldy = Client.new({:id => 1, :name => "Baldy"})
      expect(baldy.id()).to(eq(1))
    end
  end

  describe("#name") do
    it("returns the name of a client") do
      baldy = Client.new({:id => 1, :name => "Baldy"})
      expect(baldy.name()).to(eq("Baldy"))
    end
  end

  describe("#stylist_id") do
    it("returns the stylist_id of a client") do
      baldy = Client.new({:id => 1, :name => "Baldy", :stylist_id => 12})
      expect(baldy.stylist_id()).to(eq(12))
    end
  end

  describe("#==") do
    it("will return true in a comparison of clients if their names and ids are the same") do
      baldy1 = Client.new({:id => 1, :name => "Baldy"})
      baldy2 = Client.new({:id => 1, :name => "Baldy"})
      expect(baldy1).to(eq(baldy2))
    end
  end

  describe("#save") do
    it("adds a client to the database") do
      baldy = Client.new({:name => "Baldy"})
      baldy.save()
      expect(Client.all()).to(eq([baldy]))
    end
  end

  describe("#assign") do
    it("assigns a client to a stylist") do
      baldy = Client.new({:id => 1, :name => "Baldy"})
      baldy.save()
      bobbi = Stylist.new({:name => "Bobbi"})
      bobbi.save()
      baldy.assign(bobbi)
      expect(baldy.stylist_id()).to(eq(bobbi.id()))
    end
  end

  describe(".find") do
    it("finds a client based on a given client id") do
      baldy = Client.new({:id => 1, :name => "Baldy"})
      baldy.save()
      expect(Client.find(baldy.id())).to(eq(baldy))
    end
  end

  describe(".clear") do
    it("clears the list of clients") do
      baldy = Client.new({:id => 1, :name => "Baldy"})
      baldy.save()
      Client.clear()
      expect(Client.all()).to(eq([]))
    end
  end

  describe(".all") do
    it("returns all of the clients in the database - alphabetized") do
      hairy = Client.new({:id => 2, :name => "Hairy"})
      hairy.save()
      baldy = Client.new({:id => 1, :name => "Baldy"})
      baldy.save()
      expect(Client.all()).to(eq([baldy, hairy]))
    end
  end
end
