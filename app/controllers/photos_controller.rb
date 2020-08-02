class PhotosController < ApplicationController

  def new
  end

  def create
    uploaded_io = params['picture']
    metadata = 'data:image/png;base64,'
    base64_string = uploaded_io[metadata.size..-1]
    blob = Base64.decode64(base64_string)
    image = MiniMagick::Image.read(blob)

    image_name = "public/pictures/#{SecureRandom.uuid}.jpeg"
    image.write image_name

    loc = { etagere: params[:etagere], porte: params[:porte], etage: params[:etage], pic_path: image_name }

    Photo.create!( pic_path: image_name, pic_localization: loc )
  end

end
