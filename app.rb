require('sinatra')
require('sinatra/reloader')
require('./lib/task')
require('./lib/list')
also_reload('lib/**/*.rb')
require("pg")


# As a user, I want to see a welcome page that includes where I can go and what I can do.
# As a user, I want to create new lists of different categories, so that I can keep similar tasks together (phone calls, schoolwork, housework, errands to run, bills to pay, etc).
# As a user, I want to see all of the lists that I have created, so that I can manage them one at a time.

DB = PG.connect({:dbname => "to_do"})

get('/') do
  erb(:index)
end

get("/lists/new") do
  erb(:list_form)
end

post ('/lists') do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  erb(:list_success)
end
