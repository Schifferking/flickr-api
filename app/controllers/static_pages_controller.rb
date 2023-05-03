class StaticPagesController < ApplicationController
  def index
    obtain_user_photos if params.key?(:id)
  end

  private

  def obtain_user_photos
    flickr = Flickr.new ENV['FLICKR_API_KEY'], ENV['FLICKR_SECRET']
    @response = flickr.people.getPublicPhotos(api_key: ENV['FLICKR_API_KEY'], user_id: params[:id])
    @photos = []
    @response.each do |p|
      @photos << "https://live.staticflickr.com/#{p.server}/#{p.id}_#{p.secret}.jpg
      "
    end
  end
end
