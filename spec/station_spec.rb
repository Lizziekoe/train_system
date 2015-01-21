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

end
