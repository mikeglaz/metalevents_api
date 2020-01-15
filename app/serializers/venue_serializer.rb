class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :city, :state, :url
end

