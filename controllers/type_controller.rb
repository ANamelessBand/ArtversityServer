module ArtversityServer
  class TypeController < Base
    get '/', provides: :json do
      status 200
      body Type.all_data.to_json
    end

    get '/:id', provides: :json do
      status 200
      type = Type.find(id: params[:id])

      if type.nil?
        status 404
      else
        status 200

        type.categories_data.to_json
      end

    end
  end
end
