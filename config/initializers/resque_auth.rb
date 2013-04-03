Resque::Server.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["admin", "9hebruMethubeJuC"]
end
