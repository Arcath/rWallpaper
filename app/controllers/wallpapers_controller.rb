class WallpapersController < ApplicationController
    def index
        wallpaper=Wallpaper.new(params[:width].to_i,params[:height].to_i)

        #What type of Image?      
        if Setting.find_by_key("l").selected == "Full Size Image" then
            wallpaper.full_image
            wallpaper.rescale
        elsif Setting.find_by_key("l").selected == "Centered Image" then
            wallpaper.central_image(Setting.find_by_key("bgc").value)
        end

        #Text Variables        
        if Setting.find_by_key("ps").value == "true" then
            computer="Computer: #{params[:computer]}"
            user="Username: #{params[:user]}"
        else
            computer=params[:computer]
            user=params[:user]
        end
        #Write the Text
        wallpaper.text(Setting.find_by_key("n").value,"White",36)
        wallpaper.text(computer)
        wallpaper.text(user) 

        send_data(wallpaper.to_user, :disposition => 'inline', :type => 'image/png')
    end
end
