# GoogleStaticMap-Clusters

![Google Static Map with clusters](https://cloud.githubusercontent.com/assets/6061036/7803404/9e4dd9e0-0324-11e5-8719-fedf9ccd9098.png)

Add points layers, cluster them and get the link to the static map. Each cluster is represented by a marker.

Based on [this post](http://www.appelsiini.net/2008/introduction-to-marker-clustering-with-google-maps).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'googlestaticmap-clusters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install googlestaticmap-clusters

## Usage

```ruby
  require 'googlestaticmap-clusters'
  
  data = {:customers=>[{:lat=>-23.607581, :lon=>-46.630046,...},
                      {:lat=>-23.511634, :lon=>-46.71541,...},...],
          :sellers => [{:lat=>-23.607551, :lon=>-46.630034,...},
                       {:lat=>-23.511644, :lon=>-46.71543,...},...]}
                       
  map = GoogleStaticMapClusters::Map.new({:zoom => 9})
  
  map.add_layer(data[:customers])
  map.add_layer(data[:sellers],{:style=>{:marker_color=>'red'}})
  
  puts map.link
```

### Options with default values

```ruby
defaults = {
          :sensor => false,
          :map_width =>600,
          :map_height => 600,
          :style => {:marker_size => 'mid', :marker_color => 'blue'},
          :zoom => 12,
          :max_distance => 50, # distance for clustering
          :outliers_distance => 700 # distance for cleaning outliers
      }
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/googlestaticmap-clusters/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
