json.data do
  json.note do
    json.partial! 'notes/note', note: @note
  end
end