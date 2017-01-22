Dir.glob("#{Rails.root}/lib/ext/*").each do |file|
  require file
end
