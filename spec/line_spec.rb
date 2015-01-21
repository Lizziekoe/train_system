require('spec_helper')

describe(Line) do

  describe("#name") do
    it("returns the name of the line") do
      test_line = Line.new({:name => "Pink", :id => nil})
      expect(test_line.name()).to(eq("Pink"))
    end
  end

  describe("#id") do
    it("returns the id of a line") do
      test_line = Line.new({:name => "Red", :id => nil})
      test_line.save()
      expect(test_line.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("saves all the lines to the database") do
      test_line = Line.new({:name => "Red", :id => nil})
      test_line.save()
      expect(Line.all()).to(eq([test_line]))
    end
  end

  describe(".all") do
    it("starts out without any lines") do
      expect(Line.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is teh same if the name and id are the same") do
      line1 = Line.new({:name => "Red", :id => nil})
      line2 = Line.new({:name => "Red", :id => nil})
      expect(line1).to(eq(line2))
    end
  end

  describe(".find") do
    it("returns a line by a given id") do
      line1 = Line.new({:name => "Red", :id => nil})
      line2 = Line.new({:name => "Pink", :id => nil})
      line1.save()
      line2.save()
      expect(Line.find(line1.id())).to(eq(line1))
    end
  end

  describe("#update") do
    it("allows the user to update a line name") do
      line1 = Line.new({:name => "Red", :id => nil})
      line1.save()
      line1.update({:name => "Pink"})
      expect(line1.name()).to(eq("Pink"))
    end
  end

  describe("#delete") do
    it("deletes a line") do
      line1 = Line.new({:name => "Red", :id => nil})
      line2 = Line.new({:name => "Pink", :id => nil})
      line1.save()
      line2.save()
      line2.delete()
      expect(Line.all()).to(eq([line1]))
    end
  end
end
