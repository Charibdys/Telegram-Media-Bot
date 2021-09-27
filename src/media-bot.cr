require "tourmaline"
require "yaml"

class MediaBot < Tourmaline::Client  
  def pick_file
    path = Dir.glob("res/*").sample.to_s
  end

  #NOTE: If the MP4 has sound, it will be sent as a file, not as a "GIF"
  #TODO: Find a way to check MP4 for sound 
  def send_file(path)
    case File.extname(path)
    when ".gif", ".mp4"
      send_document(CHANNEL, path)
    when ".jpg", ".jpeg", ".png"
      send_photo(CHANNEL, path)
    end
  end
end

# Change working directory to media-bot
# This is needed so the executable can be ran anywhere
Dir.cd(File.dirname(__DIR__))


CONFIG = File.open(File.expand_path("config.yaml")) do |file|
  YAML.parse(file)
end

TOKEN = CONFIG["api-token"].to_s
CHANNEL = CONFIG["channel-id"].to_s

bot = MediaBot.new(bot_token: TOKEN)
bot.send_file(bot.pick_file)
