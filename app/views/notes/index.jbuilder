json.data do
  json.notes @notes, partial: '/notes/note', as: :note
end