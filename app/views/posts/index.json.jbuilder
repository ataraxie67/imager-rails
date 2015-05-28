json.array!(@posts) do |post|
  json.extract! post, :id, :title, :upvote, :downvote
  json.url post_url(post, format: :json)
end
