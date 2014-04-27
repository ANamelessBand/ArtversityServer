module ArtversityServer
  class PerformancesController < Base
    NEARBY_RANGE = 0.002

    get '/all', provides: :json do
      status 200
      body Performance.core_data.to_json
    end

    get '/:id', provides: :json do
      performance = Performance.find(id: params[:id])

      if performance.nil?
        status 404
      else
        status 200
        body performance.full_data.to_json
      end
    end

    get '/nearby/:latitude/:longitude', provides: :json do
      latitude  = params[:latitude].to_f
      longitude = params[:longitude].to_f
      performances = Performance.nearby(latitude, longitude, NEARBY_RANGE)

      status 200
      body performances.map(&:full_data).to_json
    end

    get '/recent/:latitude/:longitude', provides: :json do
      latitude  = params[:latitude].to_f
      longitude = params[:longitude].to_f
      performances = Performance.recent(latitude, longitude, NEARBY_RANGE)

      status 200
      body performances.map(&:full_data).to_json
    end

    post '/', provides: :json do
      # TODO: extract this logic to helpers
      type_name = params['type'].capitalize
      type      = Type.find name: type_name

      categories_names = param['categories'].map &:capitalize
      categories       = categories_names.map do |ctaegory|
        Category.find name: category
      end

      location_latitude = params['location_latitude'].to_f
      location_longitude = params['location_longitude'].to_f

      is_band = params['isBand'] == 'true'

      performance = Performance.new type: type,
                                    location_latitude: location_latitude,
                                    location_longitude: location_longitude,
                                    is_band: is_band
      categories.each do |category|
        performance.add_category category
      end
      performance.tag

      status 200

      id_hash = {id: performance.id}
      body id_hash.to_json
    end

    put '/', provides: :json do
      performance = Performance.find(id: params[:id])

      if performance.nil?
        status 404
      else
        performance.tag

        status 200

        id_hash = {id: performance.id}
        body id_hash.to_json
      end
    end
  end
end
