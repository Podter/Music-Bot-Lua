_G.discordia = require("discordia")
_G.client = discordia.Client()
discordia.extensions()
_G.spawn = require("coro-spawn")
_G.split = require("coro-split")
_G.parse = require("url").parse
_G.settings = require("settings")
_G.functions = require("functions")
_G.queue = {}

client:on("ready", function()
	print("Logged in as " .. client.user.username)
    client:setGame("\"help")
end)

client:on("messageCreate", function(message)
    if message.author.bot or message.author == client.user then return end -- Check if not Bot
    local args = message.content:split(" ")

	if args[1] == settings.Prefix .. "ping" then -- !ping
        functions.reply("Pong! 🏓", message)

    elseif args[1] == settings.Prefix .. "play" then -- !play [Youtube URL]
        local author = message.guild:getMember(message.author.id)
        local vc
        if not author.voiceChannel and not client.user.voiceChannel then
            message:addReaction("❌")
            functions.reply("Join Voice Channel to Get Started! 🎶", message)
        elseif client.user.voiceChannel then
            vc = client.user.voiceChannel
        else
            table.remove(args, 1)
            local vid = table.concat(args, ' ')
            vc = author.voiceChannel
            _G.connection = vc:join()
            message:addReaction("👍")
            local youtubeEmbed = message.channel:send {
                embed = {
                  fields = {
                    {name = "Please wait...", value = "This may took a while (~15 seconds)", inline = true},
                  },
                  title = "Downloading 🕔",
                  color = discordia.Color.fromRGB(114, 137, 218).value,
                },
                reference = {
                    message = message,
                    mention = false,
                  }
              }
            _G.stream = functions.getYoutube(vid)
            youtubeEmbed:update{
                embed = {
                  image = {
                      url = youtubeThumbnail
                  },
                  fields = {
                    {name = playing, value = "Uploaded by **" ..youtubeUploader.. "**", inline = true},
                  },
                  title = "Now Playing 🎶",
                  color = discordia.Color.fromRGB(114, 137, 218).value,
                },
                reference = {
                    message = message,
                    mention = false,
                  }
              }
            client:setGame("▶ " .. playing)
            coroutine.wrap(function()
                connection:playFFmpeg(stream)
                client:setGame("⏹ Nothing")
            end)()
        end

    elseif args[1] == settings.Prefix .. "pause" then -- !pause
        connection:pauseStream()
        client:setGame("⏸ " .. playing)
        message:addReaction("⏸")

    elseif args[1] == settings.Prefix .. "resume" then -- !resume
        connection:resumeStream()
        client:setGame("▶ " .. playing)
        message:addReaction("▶")

    elseif args[1] == settings.Prefix .. "stop" then -- !stop
        connection:stopStream()
        if functions.fileExists(fileName) then
            os.remove(fileName)
        end
        client:setGame("⏹ Nothing")
        message:addReaction("⏹")

    elseif args[1] == settings.Prefix .. "disconnect" then -- !disconnect
        connection:stopStream()
        connection:close()
        client:setGame("\"help")
        message:addReaction("👋")
        
    elseif args[1] == settings.Prefix .. "join" then -- !join
        local author = message.guild:getMember(message.author.id)
        local vc
        if not author.voiceChannel and not client.user.voiceChannel then
            message:addReaction("❌")
            functions.reply("Join Voice Channel to Get Started! 🎶", message)
        elseif client.user.voiceChannel then
            vc = client.user.voiceChannel
        else
            vc = author.voiceChannel
            _G.connection = vc:join()
            message:addReaction("👍")
        end
    elseif args[1] == settings.Prefix .. "help" then --!help
        message.channel:send {
            embed = {
              fields = {
                {name = "These are list of commands!", value = "\"help = Show this thing!\n\"ping = Ping!\n\"join = Connect to VC\n\"play [Youtube URL/Search] = Play music in VC\n\"pause = Pause Music\n\"resume = Resume Music\n\"stop = Stop Music\n\"disconnect = Disconnect VC\n \nPrefix for this bot is \"", inline = true},
              },
              title = "Commands 🤖",
              color = discordia.Color.fromRGB(114, 137, 218).value,
            },
            reference = {
                message = message,
                mention = false,
              }
          }
    end
end)

client:run("Bot " ..settings.Token)