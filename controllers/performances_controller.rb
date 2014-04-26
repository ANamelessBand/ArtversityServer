module ArtversityServer
  class PerformancesController < Base
    get '/all', provides: :json do
      status 200
      body Performance.all.map(&:core_data).to_json
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
      performances = Performance.find(id: params[:id]).filter |p| do
        p.nearby?(params[:latitude], params[:longitude])
      end

      status 200
      body performances.full_data.to_json
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
