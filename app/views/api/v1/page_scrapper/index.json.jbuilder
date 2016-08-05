@pages.each do |page|
  json.partial! 'common', locals: { page: page }
end