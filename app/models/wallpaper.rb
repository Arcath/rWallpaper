class Wallpaper
    require 'rubygems'
    require 'RMagick'
    def initialize(w,h)
        @width=w
        @height=h
        @strings=[]
        @from_top=26
    end
    
    def full_image
        @wallpaper=Magick::Image.read("#{RAILS_ROOT}/public/images/rails.png").first
    end    

    def central_image(bgc)
        smallimage=Magick::Image.read("#{RAILS_ROOT}/public/images/rails.png").first
        bg=Magick::Image.new(@width,@height).color_floodfill(5,5,background_color(bgc,smallimage))
        @wallpaper = bg.composite(smallimage, Magick::CenterGravity, Magick::OverCompositeOp)
        @wallpaper.format = "png"
    end

    def rescale
        @wallpaper=@wallpaper.scale(@width, @height)
    end

    def text(string,color = "white", size = 24)
            @strings.push([string,color,size])
    end

    def to_user
        text=Magick::Draw.new
        text.font_family = 'Arial'
        @strings.each do |string|
            text.pointsize=string[2]
            text.annotate(@wallpaper,0,0,@width-inset,from_top(string),string[0]) do
                self.fill = string[1]
            end
        end
        @wallpaper.to_blob
    end

    private

    def inset
        @inset || calculate_inset
    end

    def calculate_inset
        @strings.each do |string|
            ninset=string[0].length*(string[2]/2)
            @inset = ninset if ninset >= (@inset || 0)
        end
        @inset
    end

    def from_top(string)
            r=@from_top
            @from_top+=(string[2]-2)
            r
    end

    def background_color(bgc,smallimage)
        if bgc != "calculate" then
            return bgc
        elsif bgc == "calculate" then 
            return generated_bg_color(smallimage)
        else #Just to stop invalid input from breaking it
            return "#FFFFFF"
        end
    end

    def generated_bg_color(smallimage)
        smallimage.pixel_color(0,0)
    end

end
