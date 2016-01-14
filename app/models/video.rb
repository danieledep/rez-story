def video_info
  VideoInfo.new(@attrs[:video_info]) unless @attrs[:video_info].nil?
end