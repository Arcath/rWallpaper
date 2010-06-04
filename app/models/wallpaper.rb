class Wallpaper
    require 'rubygems'
    require 'RMagick'
    def initialize(w,h,img)
        @width=w
        @height=h
        @strings=[]
        @headings=[]
        @from_top=30
        @img=img
    end
    
    def full_image
        @wallpaper=Magick::Image.read("#{RAILS_ROOT}/public/images/#{@img}").first
    end    

    def central_image(bgc)
        smallimage=Magick::Image.read("#{RAILS_ROOT}/public/images/#{@img}").first
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

    def heading(string,color = "white", size = 24)
            @headings.push([string,color,size])
    end

    def to_user
        text=Magick::Draw.new
        text.font_family = 'Arial'
        @headings.each do |string|
            text.pointsize=string[2]
            text.annotate(@wallpaper,0,0,@width-heading_inset,from_top(string),string[0]) do
                self.fill = string[1]
            end
        end
        @strings.each do |string|
            text.pointsize=string[2]
            text.annotate(@wallpaper,0,0,@width-inset,from_top(string),string[0]) do
                self.fill = string[1]
            end
        end
        @wallpaper.to_blob
    end

    def message(object)
        @strings.push([object.title,Setting.find_by_key("fc").value,28])
        msg=object.body
        ls=longest_string
        lines=[]
        nline=""
        words = msg.split(" ")
        words.each do |word|
            if nline.length + word.length >= (ls*2) then
                lines.push(nline)
                nline = word
            else
                nline+=" " + word
            end
            lines.push(nline) if word == words.last
        end
        lines.map { |line| @strings.push([line,Setting.find_by_key("fc").value,12]) }
    end

    def move_down(i)
        @strings.push([" ","white",i])
    end

    private

    def longest_string
        output=0
        @strings.each do |string|
            output = string[0].length if string[0].length >= output
        end
        output
    end

    def inset
        @inset || calculate_inset
    end

    def calculate_inset
        @strings.each do |string|
            ninset=string[0].length*(string[2]*0.6)
            @inset = ninset if ninset >= (@inset || 0)
        end
        @inset
    end

    def heading_inset
        @heading_inset || calculate_heading_inset
    end

    def calculate_heading_inset
        @headings.each do |string|
            ninset=string[0].length*(string[2]/2)
            @heading_inset = ninset if ninset >= (@heading_inset || 0)
        end
        @heading_inset
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
