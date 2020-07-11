require 'fileutils'
require 'mini_magick'

puts 'Localisation ?'
location = gets

DATABASE = 'db.json'
db = File.exist?( DATABASE ) ? JSON.load( File.read( DATABASE ) ) : {}

Dir.glob( '/Users/ced/Dropbox/Games/Figurines/Grognards/*.jpg' ).each do |path|
  final_path = 'pic_tree/' + File.basename( path )
  FileUtils.move path, final_path

  image = MiniMagick::Image.open(final_path)
  image.resize '640x480'
  image.write final_path

  db[ final_path ] = location

  File.open(DATABASE,'w') do |f|
    f.write(db.to_json)
  end

end