json.extract! @card, :id, :title, :list_id, :description
  json.items do
    json.partial! "item", collection: @card.items, as: :item
  end
