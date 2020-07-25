require 'sinatra'
require 'base64'
require 'mini_magick'

# set :root, '/Users/ced/ruby/games-assets/www/'
set :public_folder, '.'

post'/save' do
  puts params['picture']

  uploaded_io = params['picture']
  metadata = "data:image/png;base64,"
  base64_string = uploaded_io[metadata.size..-1]
  blob = Base64.decode64(base64_string)
  image = MiniMagick::Image.read(blob)
  image.write 'image.jpeg'
end

get '/' do
  send_file 'index.html'
  # File.read(File.join('public', 'index.html'))
  # File.read( 'index.html' )
end
