class StaticPagesController < ApplicationController
    before_action :configure_flickr

    def index
        if params[:id].present?
            @photos = fetch_photos(params[:id])
        end
    end

    def configure_flickr
        flickr_key = Figaro.env.flickr_key
        flickr_secret = Figaro.env.flickr_secret

        Flickr.configure do |config|
            config.api_key = flickr_key
            config.shared_secret = flickr_secret
        end

    end

    private
    def fetch_photos(id)
        Flickr.people.find(id).public_photos(sizes: true).map(&:medium500!)
    end
end
