require('spec_helper')

describe(Station) do

  describe("#name") do
    it("returns the name of the station") do
      test_station = Station.new({:name => "Seattle", :id => nil})
      expect(test_station.name()).to(eq("Seattle"))
    end
  end

  describe("#id") do
    it("returns the id of a station") do
      test_station = Station.new({:name => "Portland", :id => nil})
      test_station.save()
      expect(test_station.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("saves all the stations to the database") do
      test_station = Station.new({:name => "Portland", :id => nil})
      test_station.save()
      expect(Station.all()).to(eq([test_station]))
    end
  end

  describe(".all") do
    it("starts out without any stations") do
      expect(Station.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is teh same if the name and id are the same") do
      station1 = Station.new({:name => "Portland", :id => nil})
      station2 = Station.new({:name => "Portland", :id => nil})
      expect(station1).to(eq(station2))
    end
  end

  describe(".find") do
    it("returns a station by a given id") do
      station1 = Station.new({:name => "Portland", :id => nil})
      station2 = Station.new({:name => "Seattle", :id => nil})
      station1.save()
      station2.save()
      expect(Station.find(station1.id())).to(eq(station1))
    end
  end

  describe("#update") do
    it("allows the user to update a station name") do
      station1 = Station.new({:name => "Portland", :id => nil})
      station1.save()
      station1.update({:name => "Seattle"})
      expect(station1.name()).to(eq("Seattle"))
    end
  end

  describe("#delete") do
    it("deletes a station") do
      station1 = Station.new({:name => "Portland", :id => nil})
      station2 = Station.new({:name => "Seattle", :id => nil})
      station1.save()
      station2.save()
      station2.delete()
      expect(Station.all()).to(eq([station1]))
    end
  end

  describe("#add_line") do
    it("adds a line to a station") do
      station1 = Station.new({:name => "Portland", :id => nil})
      station1.save()
      line1 = Line.new({:name => "Red", :id => nil})
      line1.save()
      station1.add_line(line1)
      expect(station1.which_lines()).to(eq([line1]))
    end
  end

    describe("#which_lines") do
      it("tells the operator which lines the station holds") do
        station1 = Station.new({:name => "Portland", :id => nil})
        station1.save()
        line1 = Line.new({:name => "Red", :id => nil})
        line1.save()
        line2 = Line.new({:name => "Blue", :id => nil})
        line2.save()
        station1.add_line(line1)
        station1.add_line(line2)        
        expect(station1.which_lines()).to(eq([line1, line2]))
      end
    end


end
