class Line

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    lines = []
    returned_lines.each() do |line|
      name = line.fetch('name')
      id = line.fetch('id').to_i()
      lines.push(Line.new({:name => name, :id => id}))
    end
    lines
  end

  define_method(:==) do |another_line|
    self.name().==(another_line.name()).&(self.id().==another_line.id())
  end

  define_singleton_method(:find) do |id|
    found_line = nil
    Line.all().each() do |line|
      if line.id().==(id)
        found_line = line
      end
    end
    found_line
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE lines SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM lines WHERE id = #{self.id()};")
  end

  define_method(:which_stations) do
    results = DB.exec("SELECT * FROM stops WHERE line_id = #{self.id()};")
    stations = []
    results.each() do |stop|
      station_id = stop.fetch("station_id").to_i()
      found_station = Station.find(station_id)
      stations.push(found_station)
    end
    stations
  end
end
