module ArtversityServer
  class TypeController < Base
    get '/', provides: :json do
      status 200
      body Type.all_data.to_json
    end
  end
end
