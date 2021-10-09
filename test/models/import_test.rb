# bundle exec ruby -Itest test/models/import_test.rb

require 'test_helper'

class ImportTest < ActiveSupport::TestCase

  require 'csv'

  def setup
    Product.delete_all
  end

  def test_import_good_file_dry_run_on
    file = "#{Rails.root}/tmp/products.csv"

    import = import({file: file})
    import.perform

    assert import.errors.blank?
    assert_equal 0, Product.all.count
  end

  def test_import_good_file_dry_run_off
    file = "#{Rails.root}/tmp/products.csv"
    row = ["Product_2", "Description product_2", "product_2.jpeg", 5.90]

    import = import({file: file, dry_run: 'false'})
    import.perform

    assert import.errors.blank?
    assert_equal 3, Product.all.count

    assert_equal row[0], Product.first.title
  end

  ##############################################################################

  def test_import_bad_file
    array = []

    path = "#{Rails.root}/tmp"
    filename = 'bad_file.csv'
    file = Tempfile.new("#{filename}", "#{path}")

    errors = [{:wrong_csv => "empty csv file"}]
    fill_csv(file, array)

    import = import({file: file})

    assert_equal errors[0], import.errors

    #########################################
    array = [["Title", "Description", "Image", "Wrong"],
             ["Product_2", "Description product_2", "product_2.jpeg", 5.90] 
            ]

    path = "#{Rails.root}/tmp"
    filename = 'bad_file.csv'
    file = Tempfile.new("#{filename}", "#{path}")

    errors = [{:missing_header => "header matching not found with 'Price'"}]
    fill_csv(file, array)

    import = import({file: file})

    assert_equal errors[0], import.errors
  end

  def import(params)
    Import.new(params)
  end

  def fill_csv(csv, array)
    CSV.open(csv, "w", col_sep: ';') do |csv|
      array.each do |line|
        csv << line
      end
    end
  end

end
