class ImageOrganizer
  attr_reader :photos

  def initialize(photo_filepath)
    @photos = read_photos(photo_filepath)
  end

  def sort_photos
    location_counts = count_locations
    photos_with_id = find_order_ids
    new_photos = photos_with_id.map do |photo|
      new_photo_name(photo:, location_counts:)
    end
    new_photos.join("\n")
  end

  def count_locations
    locations = photos.map { |photo| photo[1] }
    locations.tally
  end

  def find_order_ids
    sorted = sort_by_location_and_date
    photos_with_id = photos.dup
    current_location = sorted[0][1]
    location_index = 0
    sorted.each do |photo|
      if current_location != photo[1]
        location_index = 0
        current_location = photo[1]
      end
      match = photos_with_id.find { |photo_file| photo_file == photo }
      match << location_index += 1
    end
    photos_with_id
  end

  def sort_by_location_and_date
    photos.sort_by { |photo| [photo[1], photo[2]] }
  end

  def new_photo_name(photo:, location_counts:)
    location = photo[1]
    id = photo[3].to_s.rjust(location_counts[location].to_s.length, '0')
    type = photo[0].split('.').last
    "#{location}#{id}.#{type}"
  end

  private

  def read_photos(photo_filepath)
    IO.readlines(photo_filepath, chomp: true).map { |line| line.split(', ') }
  end
end
