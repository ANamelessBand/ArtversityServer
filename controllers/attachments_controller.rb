module ArtversityServer
  class AttachmentsController < Base
    get '/pictures' do
      erb :picture_new
    end

    post '/pictures' do
      Picture.create performance_id: params[:performance_id], filename: params[:image]
      status 200
    end

    get '/videos' do
      erb :video_new
    end

    post '/videos' do
      Video.create performance_id: params[:performance_id], filename: params[:video]
      status 200
    end

    get '/audios' do
      erb :audio_new
    end

    post '/audios' do
      Audio.create performance_id: params[:performance_id], filename: params[:audio]
      status 200
    end
  end
end
