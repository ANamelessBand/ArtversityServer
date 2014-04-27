module ArtversityServer
  class AttachmentsController < Base
    get '/pictures' do
      erb :index
    end

    post '/pictures' do
      upload = Attachment.new performance_id: 4
      upload.filename = params[:image]
      upload.save

      status 200
    end
  end
end
