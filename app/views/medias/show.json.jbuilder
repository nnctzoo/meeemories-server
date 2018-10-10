json.available @media.available?
json.sources @media.sources do |source|
  json.width source.width
  json.height source.height
  json.mime_type source.mime_type
  json.url source.url
end
