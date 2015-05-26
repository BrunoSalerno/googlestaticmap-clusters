require 'pixeldistance'
require 'rclusters'
require 'json'
require 'pry'

require 'googlestaticmap-clusters/version'

module GoogleStaticMapClusters
  class Map
    def initialize(opts = {})
      defaults = {
          :sensor => false,
          :map_width =>600,
          :map_height => 600,
          :style => {:marker_size => 'mid', :marker_color => 'blue'},
          :zoom => 12,
          :max_distance => 50, # distance for clustering
          :outliers_distance => 700 # distance for cleaning outliers
      }

      @layers = []
      @opts = defaults.merge(opts)
    end

    def add_layer(points,opts={})
      options = @opts.merge(opts)
      if options[:outliers_distance]
        points = clean_outliers(points,options[:outliers_distance],options[:zoom])
      end
      c = RClusters::ScreenDistance.new({:max_distance=>options[:max_distance],
                                         :zoom=>options[:zoom]})
      @layers.push({:clusters => (c.calculate(points)),:style => options[:style]})
    end

    def link(opts = {})
      options = @opts.merge(opts)

      link_str =''
      @layers.each  {|layer|
        layer[:clusters].each {|c|
        centroid = centroid(c[:cluster])
        str = "#{centroid[:lat]},#{centroid[:lon]}"

        link_str += "&markers=color:#{layer[:style][:marker_color]}" <<
            "%7Csize:#{layer[:style][:marker_size]}|" <<
            "label:#{c[:size] > 1 ? c[:size] : ''}|#{str}|"
        }
      }

      'http://maps.googleapis.com/maps/api/staticmap?' <<
          "size=#{options[:map_width]}x#{options[:map_height]}&sensor=#{options[:sensor]}" <<
          link_str
    end

    private

    def clean_outliers(points, max_distance, zoom)
      centroid = centroid(points)
      points.map{|point|
        pixel_distance = PixelDistance::from_coords(point[:lat], point[:lon], centroid[:lat], centroid[:lon], zoom)
        if pixel_distance > max_distance
          nil
        else
          point
        end

      }.compact
    end

    def centroid(points)
      return if points.empty?
      lats = points.inject(0) {|sum, n| sum + n[:lat]}
      lons = points.inject(0) {|sum, n| sum + n[:lon]}
      {:lat => lats/points.count, :lon => lons/points.count}
    end
  end
end
