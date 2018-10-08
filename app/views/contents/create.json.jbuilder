json.content do
  json.url "#{Rails.configuration.x.api.url}/contents/#{@media.id}"
  json.width @source.width
  json.height @source.height
  json.mimetype @source.mime_type
end