module ImageMethods

  def filepicker_api_key
    "A0dCia4jSQbatuguWKR5hz"
  end

  #
  # Sends a request to Ink Filepicker API to retrieve the key ( S3 file name )
  # for the image
  # @param  image String Filepicker image URL
  #
  # @return String Image filename on S3 bucket
  def get_s3_url(image)
    http = `curl -X POST -d url=#{image} https://www.filepicker.io/api/store/S3?key=#{filepicker_api_key}`
    response = JSON(http)
    @key = response['key']
    return @key
  end
end
