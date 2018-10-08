json.contents 1..10 do |id|
  json.id id
  json.sources [20, 200, 400, 800] do |size|
    json.width size
    json.height size
    json.mime_type 'image/jpeg'
    json.url "https://picsum.photos/#{size}/#{size}"
  end
end
