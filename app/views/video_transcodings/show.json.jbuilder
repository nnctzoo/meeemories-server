json.available @complete
json.sources @sources do |s|
  json.width s.width
  json.height s.height
  json.mime_type s.mime_type
  json.url s.url
end
