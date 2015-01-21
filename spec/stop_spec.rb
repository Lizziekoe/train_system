require('spec_helper')

describe(Stop) do

  describe("#id") do
    it("returns the id of a stop") do
      test_stop = Stop.new({:line_id => 1, :station_id => 1, :id => nil})
      test_stop.save()
      expect(test_stop.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("saves all the stops to the database") do
      test_stop = Stop.new({:line_id => 1, :station_id => 1, :id => nil})
      test_stop.save()
      expect(Stop.all()).to(eq([test_stop]))
    end
  end

  describe(".all") do
    it("starts out without any stops") do
      expect(Stop.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is the same if the line_id and station_id are the same") do
      stop1 = Stop.new({:line_id => 1, :station_id => 1, :id => nil})
      stop2 = Stop.new({:line_id => 1, :station_id => 1, :id => nil})
      expect(stop1).to(eq(stop2))
    end
  end

  describe(".find") do
    it("returns a stop by a given id") do
      stop1 = Stop.new({:line_id => 1, :station_id => 1, :id => nil})
      stop2 = Stop.new({:line_id => 1, :station_id => 1, :id => nil})
      stop1.save()
      stop2.save()
      expect(Stop.find(stop1.id())).to(eq(stop1))
    end
  end

  describe("#delete") do
    it("deletes a stop") do
      stop1 = Stop.new({:line_id => 1, :station_id => 1, :id => nil})
      stop2 = Stop.new({:line_id => 1, :station_id => 1, :id => nil})
      stop1.save()
      stop2.save()
      stop2.delete()
      expect(Stop.all()).to(eq([stop1]))
    end
  end

end
