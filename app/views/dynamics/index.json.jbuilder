json.array!(@dynamics) do |dynamic|
  json.extract! dynamic, :id, :name, :descricao
  json.url dynamic_url(dynamic, format: :json)
end
