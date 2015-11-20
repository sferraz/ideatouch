json.array!(@votes) do |vote|
  json.extract! vote, :id, :participant_id, :dynamic_id, :note_id
  json.url vote_url(vote, format: :json)
end
