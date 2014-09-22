json.array! @friends do |friend|
  json.email friend.email
  json.image friend.avatar.url(:thumb)
  json.id    friend.id
end
