[
    ["n","Name","rWallpaper","string", "The name that appears at the top of the wallpaper"],
    ["ps","Show Precedidng Strings","true","bool", "Show the Computer: and Username: on the wallpaper"],
    ["l","Layout","{Full Size Image}|Centered Image","choice","Choose how the image is displayed"]
].each do |sa|
    setting=Setting.find_or_create_by_key(sa[0])
    setting.name=sa[1]
    setting.value = sa[2] if setting.value == nil
    setting.datatype = sa[3]
    setting.description = sa[4]
    setting.save
end
