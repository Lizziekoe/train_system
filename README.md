##Train System

This will create an app so that operators and riders can see and alter train stations and lines.

##Setup
Assuming you have ruby installed. In the terminal:

`gem install bundle`

`bundle`

`ruby app.rb`

In psql create a databases titled train_system and train_system_test

the tables in the databases are titled "stations" and "lines" and a join table called "stops"

The stations table included: name (varchar), and its own id

the lines table included its own id, and names (varchar)

The stops table included its own id, the line_id, and the station_id

Go to http://localhost:4567 in your browser

##Tests
Testing the ruby methods can be done via rspec.

`gem install rspec`

`rspec`

##Motivation

To practice Object oriented programming, PATCH and DELETE methods/routes

##Bugs
When adding a line to a specific station, you can add the same one multiple times (which shouldnt be the case!)

Rider interface doesnt work yet! (but we know how to code it.....)

##License

MIT License, copyright 2015. Created by Kathryn Carr and Jackie Fletcher.
