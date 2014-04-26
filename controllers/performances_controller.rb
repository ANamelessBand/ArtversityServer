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

    get '/nearby/:longitude/:latitude', provides: :json do
      performances = Performance.nearby(params[:latitude], params[:longitude], NEARBY_RANGE)

      status 200
      body performances.map(&:full_data).to_json
    end

    get '/recent/:longitude/:latitude', provides: :json do
      performances = Performance.recent(params[:latitude], params[:longitude], NEARBY_RANGE)

      status 200
      body performances.sort_by(:last_seen).map(&:full_data).to_json
    end

    post '/', provides: :json do
      performance = Performance.new(params[:performance])
      performance.tag
      performance.save

      status 200
    end

    put '/', provides: :json do
      performance = Performance.find(id: params[:id])

      if performance.nil?
        status 404
      else
        performance.tag
        performance.save

        status 200
      end
    end
  end
end
