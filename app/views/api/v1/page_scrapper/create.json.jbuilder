if @page.errors.present?
  json.error @page.errors.full_messages.first
else
  json.partial! 'common', locals: { page: @page }
end