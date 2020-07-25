require 'sinatra'
require 'base64'
require 'mini_magick'
require 'securerandom'
require 'yaml'

set :public_folder, '.'

post'/save' do
  uploaded_io = params['picture']
  metadata = 'data:image/png;base64,'
  base64_string = uploaded_io[metadata.size..-1]
  blob = Base64.decode64(base64_string)
  image = MiniMagick::Image.read(blob)

  image_name = "pictures/#{SecureRandom.uuid}.jpeg"
  image.write image_name

  db = File.exist?( 'data.yaml' ) ? YAML.load_file( 'data.yaml' ) : {}

  db[params[:pic_type]] ||= []
  db[params[:pic_type]] << {
    etagere: params[:etagere], porte: params[:porte], etage: params[:etage], pic_path: image_name }

  File.open( 'data.yaml', 'w' ) { |file| file.write(db.to_yaml) }
end

get '/' do
  send_file 'index.html'
  # File.read(File.join('public', 'index.html'))
  # File.read( 'index.html' )
end