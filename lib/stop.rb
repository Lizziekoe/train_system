class Stop

  attr_reader(:line_id, :station_id, :id)

  define_method(:initialize) do |attributes|
    @line_id = attributes.fetch(:line_id)
    @station_id = attributes.fetch(:station_id)
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{@line_id}, #{@station_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_stops = DB.exec("SELECT * FROM stops;")
    stops = []
    returned_stops.each() do |stop|
      line_id = stop.fetch('line_id').to_i()
      station_id = stop.fetch('station_id').to_i()
      id = stop.fetch('id').to_i()
      stops.push(Stop.new({:line_id => line_id, :station_id => station_id, :id => id}))
    end
    stops
  end

  define_method(:==) do |another_stop|
    self.line_id().==(another_stop.line_id()).&(self.station_id().==(another_stop.station_id()))
  end

  define_singleton_method(:find) do |id|
    found_stop = nil
    Stop.all().each() do |stop|
      if stop.id().==(id)
        found_stop = stop
      end
    end
    found_stop
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stops WHERE id = #{self.id()};")
  end

end
