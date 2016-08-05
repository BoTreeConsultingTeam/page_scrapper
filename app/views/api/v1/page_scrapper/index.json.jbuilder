json.array! @pages do |page|
  json.partial! 'common', locals: { page: page }
end