#Seattle Alerts
A Rails app which converts JSON 911 data from data.seattle.gov and displays markers via the google maps API.

Seattle Alerts receives data from data.seattle.gov which utilizes an API produced by Socrata. The City of Seattle reports that the dataset is refreshed on a 4 hour interval, but appears to be updated more frequently. The 911 Fire data set is updated every five minutes.

##Setup
In your terminal, clone this repo:

```console
$ git clone https://github.com/JeffStringer/seattle-alerts 
```

Make sure you've installed [postgres](http://www.postgresql.org/download/) and have started the server:

```console
$ postgres
```

Install all the dependencies:

```console
$ bundle install
```

Set up the databases on your local machine:

```console
$ rake db:create
$ rake db:schema:load
```

Finally, start the rails server:

```console
$ rails s
```
It should now be available at `localhost:3000` or you may see the deployed app at [http://seattle-alerts.herokuapp.com/](http://seattle-alerts.herokuapp.com/)


##Wiki
Please refer to the [wiki](https://github.com/JeffStringer/seattle-alerts/wiki) for this project for more information including the elevator pitch, initial user stories, scenarios and wire frames written in Balsamiq.
##Author
[Jeff Stringer](http://jeffstringer.herokuapp.com)

##License
MIT
