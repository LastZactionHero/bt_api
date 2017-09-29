# Boulder Tubing Conditions

App returns the weather and river conditions for Boulder Creek.

## Usage

```
bundle install
rackup
```

## API

```
/conditions

{
  "temperature_f":"43",
  "weather_condition":"Cloudy",
  "flow_rate_cfs":58.0
}
```

For all condition text, see Yahoo documentation, under "Condition Codes":

[Yahoo Documentation](https://developer.yahoo.com/weather/documentation.html)