# Miniweather

Basic Rails 5 application that allows the user to check the current weather in the desired city.


### Installing notes
When running in systems that use docker-machine (f.e. Windows 10 Home or lesser), localhost address is not exposed directly in the browser. It's necessary to run `docker-machine ip` to get the IP of the generated docker-machine and use that address in the browser `<ip_given>:3000`.
In this case this IP needs to be changed also in `config/settings.yml` so the database can be found.
