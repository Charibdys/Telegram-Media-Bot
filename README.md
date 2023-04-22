# Telegram Media Bot

A simple Telegram bot that sends a random picture or GIF to a channel.  
Written in Crystal using Tourmaline.

## Installation

~~~
git clone https://gitlab.com/Charibdys/telegram-media-bot.git
cd telegram-media-bot
shards install
shards build --release
~~~

## Usage

After installing the shards:
1. Add any pictures, GIFs, or videos (MP4's without sound) to the `res` directory
2. Rename `config.yaml.copy` to `config.yaml`
3. Change `config.yaml` so that it has the correct bot token and channel ID (this should be a negative 13 digit number, i.e., `-100XXXXXXXXXX`)
4. Run the binary found in `telegram-media-bot/bin/media-bot`

The bot sends one file to the channel and quits. You may want to set up a `crontab` if you want multiple files uploaded over time.

## Development

This program is considered complete. However, it has a few limitations:

- Bot cannot determine if a video (MPEG-4) has sound or not
    - If a MP4 with sound is found in the directory, it will be sent as a file
- Filenames must include an extension that matches their type (.png, .jpg, .mp4, etc)
- Files must be stored locally
- No job scheduling (for fixed-interval posts, use with `cron`)

## Contributing

1. Fork it (<https://gitlab.com/Charibdys/telegram-media-bot/-/forks/new>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Charybdis](https://gitlab.com/Charibdys) - creator and maintainer
