{
  programs.mpv = {
    enable = true;
    config = {
      vo = "gpu-next";
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
    };
  };
}
