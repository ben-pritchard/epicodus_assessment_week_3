###DESCRIPTION

This is an app for a hair salon owner to keep track of the stylists at the salon and each of the stylists associated clients.

You will seriously be like: **"Woah"**

###SETUP INSTRUCTIONS

To set up the correct databases, you will have to access psql through your console and enter the following:

CREATE DATABASE hair_salon;
\c hair_salon
CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);
CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);
CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;

Make sure Sinatra is on stage with your app.rb. Then open a web browser and go to the corresponding local host:

*example: http://localhost:4567/*

###COPYRIGHT INFORMATION

GPL v2

###LICENSE INFORMATION

GPL v2

###AUTHOR

Ben Pritchard
