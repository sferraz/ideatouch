json.array!(@boards) do |board|
  json.extract! board, :id, :name, :descricao, :dynamic_id
  json.url board_url(board, format: :json)
end
