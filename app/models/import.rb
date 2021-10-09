class Import

  require 'csv'

  attr_reader :file, :errors, :count, :dry_run

  def initialize(params)
    @errors  = Hash.new(0)
    @count   = 0
    # For security purpose dry_run is on by default, set dry_run = 'false' for real import
    @dry_run = params[:dry_run] != 'false'
    @file    = params[:file]
    file_validation
  end

  def perform
    import
  end

  def file_validation
    begin
      csv_read = CSV.read(@file, col_sep: ';')
    rescue CSV::MalformedCSVError => ex
      @errors[:malformed_csv] = ex.message
      return false
    end
    
    if csv_read.blank?
      @errors[:wrong_csv] = 'empty csv file'
      return false
    end

    title_index       = header_index(csv_read[0], 'Title')
    description_index = header_index(csv_read[0], 'Description')
    image_index       = header_index(csv_read[0], 'Image')
    price_index       = header_index(csv_read[0], 'Price')

    return false unless @errors.blank?
    return true
  end

  private

  def header_index(row, source)
    header = row.select { |r| r.downcase == source.downcase }.first

    @errors[:missing_header] = "header matching not found with '#{source}'" if header.blank?
            
    header_index = row.index(header)
    header_index
  end

  def conditions(row)
    {
      title: row[0],
      description: row[1],
      image: row[2],
      price: row[3]   
    }
  end

  def insert_row(row)
    product = Product.where(conditions(row)).first

    puts "ROW ===============< #{row}"

    if product.nil?
      product = Product.new
      product.title       = row[0]
      product.description = row[1]
      product.price       = row[3].to_f
      product.save! unless @dry_run
      attach_image(product, row[2])
      @count += 1
    end
  end

  def attach_image(product, image)
    path = Rails.root.join("app/assets/images/", "#{image}")

    File.open(path) do |io|
      product.image.attach(io: io, filename: "#{image}")
    end
  end
  
  def import
    index = 0
    logger.info " ******************************"
    logger.info " Start import - dry_run #{@dry_run == 'false' ? 'OFF' : 'ON'}"

    CSV.foreach(@file, col_sep: ';') do |row|
      index += 1
      insert_row(row) unless index == 1
    end

    logger.info " End - Imported #{@count} products"
    logger.info " ******************************"
  end

  def logger
    ::Logger.new(STDOUT)
  end

end