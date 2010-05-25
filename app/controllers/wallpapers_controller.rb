class WallpapersController < ApplicationController
    def index
        wallpaper=Wallpaper.new(params[:width].to_i,params[:height].to_i)

        wallpaper.rescale

        wallpaper.text(params[:computer])
        wallpaper.text(params[:user]) 

        send_data(wallpaper.to_user, :disposition => 'inline', :type => 'image/png')
    end
end
