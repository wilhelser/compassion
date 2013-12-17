module ImageMethods

  def filepicker_api_key
    "A0dCia4jSQbatuguWKR5hz"
  end

  def get_s3_url(image)
    http = `curl -X POST -d url=#{image} https://www.filepicker.io/api/store/S3?key=#{filepicker_api_key}`
    response = JSON(http)
    @key = response['key']
    return @key
  end
end
