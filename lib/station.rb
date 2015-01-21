class Station

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_stations = DB.exec("SELECT * FROM stations;")
    stations = []
    returned_stations.each() do |station|
      name = station.fetch('name')
      id = station.fetch('id').to_i()
      stations.push(Station.new({:name => name, :id => id}))
    end
    stations
  end

  define_method(:==) do |another_station|
    self.name().==(another_station.name()).&(self.id().==another_station.id())
  end

  define_singleton_method(:find) do |id|
    found_station = nil
    Station.all().each() do |station|
      if station.id().==(id)
        found_station = station
      end
    end
    found_station
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE stations SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stations WHERE id = #{self.id()};")
  end

  define_method(:add_line) do |line|

    new_stop = Stop.new({:line_id => line.id(), :station_id => self.id()})
    new_stop.save()
  end

  define_method(:which_lines) do
    results = DB.exec("SELECT * FROM stops WHERE station_id = #{self.id()};")
    lines = []
    results.each() do |stop|
      line_id = stop.fetch("line_id").to_i()
      found_line = Line.find(line_id)
      lines.push(found_line)
    end
    lines
  end

end
