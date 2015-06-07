json.extract! list, :id, :title, :ord
  json.cards do
    json.partial! "card", collection: list.cards, as: :card
  end
