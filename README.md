# Music-Bot-Lua
A Discord Music Bot written in Lua
# Installation
### Windows
* Install [Luvit](https://luvit.io/install.html)
* Install [FFMPEG](https://ffmpeg.org)
* Clone the repository `git clone https://github.com/Podter/Music-Bot-Lua`
* Install all packages from `package.lua` by typing `lit install`
    - This will install `SinisterRectus/discordia` `creationix/coro-spawn` and `creationix/coro-split`
* Start the bot by typing `luvit main.lua`
### Linux
* Install [Luvit](https://luvit.io/install.html)
* Insatall all required packages by typing `sudo apt-get install ffmpeg youtube-dl libopus-dev libsodium-dev`
    - This will install `FFmpeg` `youtube-dl` `Opus` and `Sodium`
* Clone the repository `git clone https://github.com/Podter/Music-Bot-Lua`
* Install all packages from `package.lua` by typing `lit install`
    - This will install `SinisterRectus/discordia` `creationix/coro-spawn` and `creationix/coro-split`
* Start the bot by typing `luvit main.lua`
### Docker
* Just run and replace `YourDiscordBotTokenHere` with your bot token
```
docker run -d -e Token=YourDiscordBotTokenHere -e Prefix=! podter/music-bot-lua
```
# Configuration
All Configurations are store in `settings.lua`
* `Prefix` is prefix for your bot, Default prefix is `!`
* `Token` is Discord Bot Token for your bot, Replace `Your Discord Bot Token Here!` with your bot token!
* To change Prefix in Docker just replace `!` with your prefix at `-e Prefix=!` like this: `-e Prefix=?`