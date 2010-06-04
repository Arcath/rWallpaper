[
    ["n","Name","rWallpaper","string", "The name that appears at the top of the wallpaper"],
    ["ps","Show Precedidng Strings","true","bool", "Show the Computer: and Username: on the wallpaper"],
    ["l","Layout","{Full Size Image}|Centered Image","choice","Choose how the image is displayed"],
    ["bgc","Background Colour","calculate","string","The Background colour for when using \"Centered Image\" wallpapers. If set to \"calculate\" instead of a HEX value rWallpaper will use the colour of the edge of the logo"],
    ["img","Image","rails.png","string","The path to an image, relative to \"#{RAILS_ROOT}/public/images/\""],
    ["fc","Font Color","#FFFFFF","string","The color of the text on the image"],
    ["ts","Date Format","%d/%m/%Y","string","The format of the date on the wallpaper, see the <a href=\"http://ruby-doc.org/core/classes/Time.html#M000298\" target=\"_BLANK\">Ruby Docs</a> for characters"],
    ["ru","Root URL","http://localhost/","string","The root URL of rWallpaper, to get this take \"settings\" off the current url."]
].each do |sa|
    setting=Setting.find_or_create_by_key(sa[0])
    setting.name=sa[1]
    setting.value = sa[2] if setting.value == nil
    setting.datatype = sa[3]
    setting.description = sa[4]
    setting.save
end
