json.array! @users do |u|
  json.email u.email
  json.id    u.id
end
