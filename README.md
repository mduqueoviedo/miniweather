# Miniweather

Basic Rails 5 application that allows the user to check the current weather in the desired city or in a random location.

## Functionalities

- Weather in location: Write a location in the form input and get the current weather in that place.
- Random location weather: If input is empty or random button pressed, the application will pick some coordinates at random and will show the weather in that specific place.
- Logs: The app will also show up to the last 10 queries and will allow to run them again with a simple click.

## Technologies

- Rails 5: Last version of Ruby on Rails.
- MongoDB 6: Simple, noSQL database system for storing the logs of the application.
- AngularJS 1.6: Frontend JS framework used to build a single page application with calls to api-like controllers.
- Rspec: Unit testing tools focused on Rails applications.
- Rubocop: Enforces the Ruby code guidelines of the Ruby Style Guide, which allows having more similar code when several developers work on the same codebase.

## Installing

After cloning the application it's necessary to create a `settings.local.yml` file in `/config/settings` with the following content:
```
weather_api:
  key: '&APPID=<app_id_provided_by_api_provider>'
```

The application runs in a Docker box, so any system with Docker installed should be able to run it.
Simply execute in the console:
- `./bin/docker/setup`
- `./bin/docker/start`
To install and start the application. In the `bin/docker` folder there are several utility scripts to run the test suites, start, stop and restart the application, start a console and other functions (execute `./bin/docker/<script_name>` when in the project folder).

**Important:** 

- When running in systems that use docker-machine instead of native Docker (e.g. Windows 10 Home or lesser), the `localhost` url is not exposed and cannot be directly accessed in the browser.
  It's necessary to run `docker-machine ip` to get the IP of the generated docker-machine and use then that address in the browser `<ip_given>:3000`.
- For unix-based systems, updating permissions for execution of scripts after cloning might be neccesary (`chmod -R 755`)

## Future improvements

- Test frontend with Capybara or other tools.
- Internationalization with I18n.
- Support for other unit types (imperial, kelvin) is implemented on the backend, a cookie or other session variable could be set so the corresponding information is shown to the user.
- Paginate the log view to show more of them.
- Improve logging in general: Only basic information is stored.
- Geolocalize the user so the application by default can show the weather in the user location.
- Move the view elements to angular components.