require "tourmaline"
require "yaml"

class MediaBot < Tourmaline::Client
  def pick_file(recent)
    path = Dir.glob("res/*").sample.to_s

    if recent != 0
      until File.info(path).modification_time < (Time.utc - recent.hours)
        path = Dir.glob("res/*").sample.to_s
      end
    end

    return path
  end

  def send_file(path)
    case File.extname(path)
    when ".jpg", ".jpeg", ".png"
      send_photo(CHANNEL, File.open(path))
    when ".gif", ".mp4"
      send_animation(CHANNEL, File.open(path))
    end
    File.touch(path)
  end
end

# Change working directory to media-bot
# This is needed so the executable can be ran anywhere
Dir.cd(File.dirname(__DIR__))

CONFIG = File.open(File.expand_path("config.yaml")) do |file|
  YAML.parse(file)
end

TOKEN   = CONFIG["api-token"].to_s
CHANNEL = CONFIG["channel-id"].to_s

begin
  recent = CONFIG["recency-limit"].to_s.to_i
rescue
  recent = 0
end

privacy_policy_handler = Tourmaline::CommandHandler.new("privacy") do |ctx|
  next unless message = ctx.message
  next if message.date == 0 

  message = message.as(Tourmaline::Message)

  next unless from = message.from

  ctx.client.send_message(from.id, "This bot does not collect or store any user information.")
end

bot = MediaBot.new(bot_token: TOKEN)
bot.register(privacy_policy_handler)
bot.set_my_commands([Tourmaline::BotCommand.new("privacy", "View the Privacy Policy for this bot")])
bot.send_file(bot.pick_file(recent))

spawn do
  bot.poll
end

# Let the bot poll for some time to catch any requests for the Privacy Policy
sleep 10.seconds