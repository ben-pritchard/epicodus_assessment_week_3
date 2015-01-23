require("spec_helper")

describe(Stylist) do
  describe(".all") do
    it("returns all of the stylists in the database - should be empty at first") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe("#id") do
    it("returns the id of a stylist") do
      bobbi = Stylist.new({:id => 1, :name => "Bobbi"})
      expect(bobbi.id()).to(eq(1))
    end
  end

  describe("#name") do
    it("returns the name of a stylist") do
      bobbi = Stylist.new({:id => 1, :name => "Bobbi"})
      expect(bobbi.name()).to(eq("Bobbi"))
    end
  end

  describe("#==") do
    it("will return true in a comparison of stylists if their names and ids are the same") do
      bobbi1 = Stylist.new({:id => 1, :name => "Bobbi"})
      bobbi2 = Stylist.new({:id => 1, :name => "Bobbi"})
      expect(bobbi1).to(eq(bobbi2))
    end
  end

  describe("#save") do
    it("adds a stylist to the database") do
      bobbi = Stylist.new({:name => "Bobbi"})
      bobbi.save()
      expect(Stylist.all()).to(eq([bobbi]))
    end
  end

  describe(".find") do
    it("finds a stylist based on a given stylist id") do
      bobbi = Stylist.new({:id => 1, :name => "Bobbi"})
      bobbi.save()
      expect(Stylist.find(bobbi.id())).to(eq(bobbi))
    end
  end

  describe(".clear") do
    it("clears the list of stylists") do
      bobbi = Stylist.new({:id => 1, :name => "Bobbi"})
      bobbi.save()
      Stylist.clear()
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe(".all") do
    it("returns all of the stylists in the database - alphabetized") do
      jo = Stylist.new({:id => 2, :name => "Jo"})
      jo.save()
      bobbi = Stylist.new({:id => 1, :name => "Bobbi"})
      bobbi.save()
      expect(Stylist.all()).to(eq([bobbi, jo]))
    end
  end

end
