class Friendship < ActiveRecord::Base
  belongs_to :source, class: "User"
  belongs_to :target, class: "User"
end
