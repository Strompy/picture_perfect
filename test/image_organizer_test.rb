require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/image_organizer'
require 'pry'

class ImageOrganizerTest < Minitest::Test
  def setup
    @test_input = './data/test_input.txt'
    @expected_output = <<~HEREDOC
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

  def test_it_organizes_images
    image_organizer = ImageOrganizer.new(@test_input)
    assert image_organizer
    # parse the string into lines for each photo
    # count the number of repeated locations to get the max number of digits for the zero adjusted id
    # sort the photos by city and date
    # create the new name
    # by adding the zero adjusted id to the end of the photo location
    # add the file extension to the end of the photo location
    # join the new sorted photo list into a string

    # return list of photos sorted by city and date with city name first followed by zero adjusted id

    assert_equal @expected_output, image_organizer.sort_photos
  end

  def test_it_splits_the_input_string_into_lines
    image_organizer = ImageOrganizer.new(@test_input)
    assert_equal 15, image_organizer.photos.length
    assert_equal ['photo.jpg', 'Krakow', '2013-09-05 14:08:15'], image_organizer.photos[0]
  end

  def test_it_counts_locations
    image_organizer = ImageOrganizer.new(@test_input)
    expected_counts = {
      'Krakow' => 10,
      'London' => 2,
      'Florianopolis' => 3
    }
    assert_equal expected_counts, image_organizer.count_locations
  end
end
