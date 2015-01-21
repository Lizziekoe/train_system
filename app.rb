require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/line')
require('./lib/station')
require('pg')

DB = PG.connect({:dbname => "train_system"})

get('/') do
  erb(:index)
end

get('/operator') do
  @stations = Station.all()
  @lines = Line.all()
  erb(:operator)
end

post('/operator_admin') do
  station_name = params.fetch("station_name")
  line_name = params.fetch("line_name")
  if station_name != ""
    new_station = Station.new({:name => station_name, :id => nil})
    new_station.save()
  end
  if line_name != ""
    new_line = Line.new({:name => line_name, :id => nil})
    new_line.save()
  end
  @stations = Station.all()
  @lines = Line.all()
  erb(:operator)
end

# Editing Stations

get('/stations/:id') do
  id = params.fetch("id").to_i
  @station = Station.find(id)
  @lines = @station.which_lines()
  @all_lines = Line.all()
  erb(:stations)
end


patch('/stations/:id/edit') do
  name = params.fetch("name")
  @station = Station.find(params.fetch("id").to_i())
  @station.update({:name => name})
  erb(:stations)
end


delete('/stations/:id/delete') do
  @station = Station.find(params.fetch("id").to_i())
  @station.delete()
  # make method to delete stops??
  @stations = Station.all()
  @lines = Line.all()
  erb(:operator)
end

post('/stations/:id/add_line') do
  @line_name = Line.find(params.fetch("line_to_add").to_i())
  @station = Station.find(params.fetch("id").to_i())
  @station.add_line(@line_name)
  @lines = @station.which_lines()
  @all_lines = Line.all()
  erb(:stations)
end



# Editing Lines

get('/lines/:id') do
  id = params.fetch("id").to_i
  @line = Line.find(id)
  erb(:lines)
end


patch('/lines/:id/edit') do
  name = params.fetch("name")
  @line = Line.find(params.fetch("id").to_i())
  @line.update({:name => name})
  erb(:lines)
end


delete('/lines/:id/delete') do
  @line = Line.find(params.fetch("id").to_i())
  @line.delete()
  # make method to delete stops??
  @stations = Station.all()
  @lines = Line.all()
  erb(:operator)
end
