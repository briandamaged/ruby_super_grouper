# SuperGrouper #

Convert collections into hierarchical groups

## Installation ##

```shell
gem install super_grouper
```

## Usage ##

```ruby
locations = [
  {country: "US", state: "Ohio",     city: "Dayton"},
  {country: "US", state: "Ohio",     city: "Cincinnati"},
  {country: "CA", state: "Manitoba", city: "Winnipeg"},
  {country: "US", state: "Virginia", city: "Falls Church"},
]

output = SuperGrouper.group(locations, [:country, :state])
```


Now, `output` is equal to:

```ruby
{
  "US"=>{
    "Ohio"=>[
      {:country=>"US", :state=>"Ohio", :city=>"Dayton"},
      {:country=>"US", :state=>"Ohio", :city=>"Cincinnati"}
    ],
    "Virginia"=>[
      {:country=>"US", :state=>"Virginia", :city=>"Falls Church"}
    ]
  },
  "CA"=>{
    "Manitoba"=>[
      {:country=>"CA", :state=>"Manitoba", :city=>"Winnipeg"}
    ]
  }
}
```

Which means that you can now do things such as:

```ruby
puts output["US"]["Ohio"]
```
