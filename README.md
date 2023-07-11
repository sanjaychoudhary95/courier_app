# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: ruby '2.7.1'

* Database: PostgreSQL

## Quick start
1) Install ruby bundler
```
gem install bundler
```
2) Install dependencies
```
bundle install
```

3)Create a database on your local PostgreSQL
```
CREATE DATABASE
rake db:create
```

4) Migrate database
```
rails db:migrate
```
5) Start the server
```
rails server
```

6) Update tracking number in existing Parcels
```
rake update_parcel:tracking_number
```

7) Manually create the report,run the command.
```
rake generate_report
```

