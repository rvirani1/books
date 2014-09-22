json.array! @requests do |user|
  json.email  user.email
  json.image  user.avatar.url(:thumb)
  json.id     user.id
end
