json.youtube_videos @videos do |video|
  json.id video.id
  json.title video.title
  json.description video.description
  json.thumbnail "https://i.ytimg.com/vi/#{video.id}/default.jpg"
end