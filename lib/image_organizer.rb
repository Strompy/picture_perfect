class ImageOrganizer
  attr_accessor :photos, :location_counts

  def initialize(photo_file)
    @photos = IO.readlines(photo_file, chomp: true).map { |line| line.split(', ') }
    # think about making this a method so it can be descriptive
    @location_counts = {}
  end

  def sort_photos
    <<~HEREDOC
      Krakow02.jpg
      London1.png
      Krakow01.png
      Florianopolis2.jpg
      Florianopolis1.jpg
      London2.jpg
      Florianopolis3.png
      Krakow03.jpg
      Krakow09.png
      Krakow07.jpg
      Krakow06.jpg
      Krakow08.jpg
      Krakow04.png
      Krakow05.png
      Krakow10.jpg
    HEREDOC
  end

  def count_locations
    locations = photos.map do |photo|
      photo[1]
    end
    @location_counts = locations.tally
  end
end
