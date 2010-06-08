class WallpapersController < ApplicationController
    def index
        wallpaper=Wallpaper.new(params[:width].to_i,params[:height].to_i,Setting.find_by_key("img").value,params[:format])

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
            user="Username: #{params[:user].gsub("&dot;",".")}"
        else
            computer=params[:computer]
            user=params[:user]
        end
        #Write the Text
        wallpaper.heading(Setting.find_by_key("n").value,Setting.find_by_key("fc").value,36)
        wallpaper.text(Time.now.strftime(Setting.find_by_key("ts").value),Setting.find_by_key("fc").value)
        wallpaper.text(computer,Setting.find_by_key("fc").value)
        wallpaper.text(user,Setting.find_by_key("fc").value) 

        #Messages
        wallpaper.move_down(20)
        Message.to_show.map { |message| wallpaper.message(message) }

        send_data(wallpaper.to_user, :disposition => 'inline', :type => "image/#{params[:format]}")
    end

    def logon
        wallpaper=Wallpaper.new(params[:width].to_i,params[:height].to_i,Setting.find_by_key("img").value,params[:format])

        #What type of Image?      
        if Setting.find_by_key("l").selected == "Full Size Image" then
            wallpaper.full_image
            wallpaper.rescale
        elsif Setting.find_by_key("l").selected == "Centered Image" then
            wallpaper.near_top_image(Setting.find_by_key("bgc").value)
        end

        #Text Variables        
        if Setting.find_by_key("ps").value == "true" then
            computer="Computer: #{params[:computer]}"
        else
            computer=params[:computer]
        end
        #Write the Text
        wallpaper.heading(Setting.find_by_key("n").value,Setting.find_by_key("fc").value,36)
        wallpaper.text(Time.now.strftime(Setting.find_by_key("ts").value),Setting.find_by_key("fc").value)
        wallpaper.text(computer,Setting.find_by_key("fc").value)

        send_data(wallpaper.to_user, :disposition => 'inline', :type => "image/#{params[:format]}")
    end
end
