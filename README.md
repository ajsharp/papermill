# Introduction

Papermill is a simple [sinatra](http://github.com/sinatra/sinatra) front-end to
[Bunyan](http://github.com/ajsharp/bunyan). Papermill was designed to query 
and analyze documents stored in a MongoDB capped collection. 

# Usage
Simply clone the repo to the location from which you want to serve the papermill
with your favorite app server.  The only configuration required is a bunyan 
configuration file to hook papermill up to MongoDB through Bunyan.

# Configuration
Copy `config/bunyan.example.rb` to `config/bunyan.rb` and change the settings
to match your MongoDB configuration.

# Features

* Web-based interface for searching, querying and filtering bunyan logs
* Statistics with pretty graphs (using raphaeljs)

# TODO

* Allow data export in json format

