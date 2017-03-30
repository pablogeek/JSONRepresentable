# JSONRepresentable
Parse Objects to Json


```
let country: Country = Country(name: "Spain")
let city: City = City(name: "Valencia", country: country)
        
let json = city.toJSON()

//This is the json String
print(json.1 ?? "")
        
// this is the json data
let data = json.0
```
