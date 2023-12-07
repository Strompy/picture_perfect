class ImageOrganizer
  attr_accessor :photos, :location_counts

  def initialize(photo_file)
    @photos = IO.readlines(photo_file, chomp: true).map { |line| line.split(', ') }
    # think about making this a method so it can be descriptive
    @location_counts = {}
  end

  def sort_photos
    count_locations
    add_image_order_id
    new_photos = photos.map do |photo|
      new_photo_name(photo:, location_counts:)
    end
    new_photos.join("\n")
  end

  def count_locations
    locations = photos.map do |photo|
      photo[1]
    end
    @location_counts = locations.tally
  end

  def add_image_order_id
    sorted = sort_by_location_and_date
    current_location = sorted[0][1]
    index = 0
    sorted.each do |photo|
      if current_location != photo[1]
        index = 0
        current_location = photo[1]
      end
      match = photos.find do |photo_file|
        photo_file == photo
      end
      match << index += 1
    end
    photos
  end

  def sort_by_location_and_date
    photos.sort_by do |photo|
      [photo[1], photo[2]]
      #   might change the nested array to a hash so we don't have magic numbers
    end
  end

  def new_photo_name(photo:, location_counts:)
    location = photo[1]
    id = photo[3].to_s.rjust(location_counts[location].to_s.length, '0')
    type = photo[0].split('.').last
    "#{location}#{id}.#{type}"
  end
end
