require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/image_organizer'
require 'pry'

class ImageOrganizerTest < Minitest::Test
  def setup
    @test_input = './data/test_input.txt'
    @expected_output = <<~HEREDOC.chomp
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

  def test_it_sorts_photos
    image_organizer = ImageOrganizer.new(@test_input)
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

  def test_it_find_order_ids_by_location_and_date
    image_organizer = ImageOrganizer.new(@test_input)
    expect_order = [
      ['photo.jpg', 'Krakow', '2013-09-05 14:08:15', 2],
      ['Mike.png', 'London', '2015-06-20 15:13:22', 1],
      ['myFriends.png', 'Krakow', '2013-09-05 14:07:13', 1],
      ['Eiffel.jpg', 'Florianopolis', '2015-07-23 08:03:02', 2],
      ['pisatower.jpg', 'Florianopolis', '2015-07-22 23:59:59', 1],
      ['BOB.jpg', 'London', '2015-08-05 00:02:03', 2],
      ['notredame.png', 'Florianopolis', '2015-09-01 12:00:00', 3],
      ['me.jpg', 'Krakow', '2013-09-06 15:40:22', 3],
      ['a.png', 'Krakow', '2016-02-13 13:33:50', 9],
      ['b.jpg', 'Krakow', '2016-01-02 15:12:22', 7],
      ['c.jpg', 'Krakow', '2016-01-02 14:34:30', 6],
      ['d.jpg', 'Krakow', '2016-01-02 15:15:01', 8],
      ['e.png', 'Krakow', '2016-01-02 09:49:09', 4],
      ['f.png', 'Krakow', '2016-01-02 10:55:32', 5],
      ['g.jpg', 'Krakow', '2016-02-29 22:13:11', 10]
    ]
    assert_equal expect_order, image_organizer.find_order_ids
  end

  def test_it_creates_new_name
    image_organizer = ImageOrganizer.new(@test_input)
    location_counts = image_organizer.count_locations
    photo1 = ['photo.jpg', 'Krakow', '2013-09-05 14:08:15', 2]
    assert_equal 'Krakow02.jpg', image_organizer.new_photo_name(photo: photo1, location_counts:)
    photo2 = ['g.jpg', 'Krakow', '2016-02-29 22:13:11', 10]
    assert_equal 'Krakow10.jpg', image_organizer.new_photo_name(photo: photo2, location_counts:)
    photo3 = ['notredame.png', 'Florianopolis', '2015-09-01 12:00:00', 3]
    assert_equal 'Florianopolis3.png', image_organizer.new_photo_name(photo: photo3, location_counts:)
  end
end
