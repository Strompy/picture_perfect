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

end
