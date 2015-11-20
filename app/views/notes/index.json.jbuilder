json.array!(@notes) do |note|
  json.extract! note, :id, :board_id, :text
  json.url note_url(note, format: :json)
end
