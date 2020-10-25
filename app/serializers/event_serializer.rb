class EventSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :venue_id, :name, :description, :date
end
