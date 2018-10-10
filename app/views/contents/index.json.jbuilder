json.contents @contents do |content|
  json.id content.id
  json.sources content.media.sources do |source|
    json.width source.width
    json.height source.height
    json.mime_type source.mime_type
    json.url source.url
  end
end
