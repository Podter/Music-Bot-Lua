local functions = {}

function functions.fileExists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end

function functions.wait(seconds)
    local start = os.time()
    repeat until os.time() > start + seconds
end

function functions.startsWith(str, start)
    return str:sub(1, #start) == start
end

function functions.getYoutubeInfo(vid)
    if functions.isYoutube(vid) then
        local child = spawn('youtube-dl', {
            args = {'-e', '--no-check-certificate', vid},
            stdio = { nil, true, 1 }
        })

        split(function()
            for data in child.stdout.read do
                _G.playing = data
            end
        end)
    else
        local child = spawn('youtube-dl', {
            args = {'-e', '--no-check-certificate', '--default-search', 'ytsearch', vid},
            stdio = { nil, true, 1 }
        })

        split(function()
            for data in child.stdout.read do
                _G.playing = data
            end
        end)
    end

    if functions.isYoutube(vid) then
        local child = spawn('youtube-dl', {
            args = {'--get-filename','-o','%(channel)s','--no-check-certificate',vid},
            stdio = { nil, true, 1 }
        })

        split(function()
            for data in child.stdout.read do
                _G.youtubeUploader = data
            end
        end)
    else
        local child = spawn('youtube-dl', {
            args = {'--get-filename','-o','%(channel)s','--no-check-certificate','--default-search','ytsearch', vid},
            stdio = { nil, true, 1 }
        })

        split(function()
            for data in child.stdout.read do
                _G.youtubeUploader = data
            end
        end)
    end

    if functions.isYoutube(vid) then
        local child = spawn('youtube-dl', {
            args = {'--get-thumbnail', '--no-check-certificate', vid},
            stdio = { nil, true, 1 }
        })

        split(function()
            for data in child.stdout.read do
                _G.youtubeThumbnail = data
            end
        end)
    else
        local child = spawn('youtube-dl', {
            args = {'--get-thumbnail', '--no-check-certificate', '--default-search', 'ytsearch', vid},
            stdio = { nil, true, 1 }
        })

        split(function()
            for data in child.stdout.read do
                _G.youtubeThumbnail = data
            end
        end)
    end 
end

function functions.getYoutube(vid)
    _G.fileName = "audio.mp3"
    connection:stopStream()
    client:setGame("⏹ Nothing")
    functions.wait(0.25)
    if functions.fileExists(fileName) then
        os.remove(fileName)
    end

    if functions.isYoutube(vid) then
        spawn('youtube-dl', {
            args = {'-o',fileName,'-f','worstaudio','--no-check-certificate', vid},
        })
    else
        spawn('youtube-dl', {
            args = {'-o',fileName,'-f','worstaudio','--no-check-certificate','--default-search','ytsearch', vid},
        })
    end

    functions.getYoutubeInfo(vid)
    client:setGame("🕔 " .. playing)

    while true do
        if functions.fileExists(fileName) then
            break
        end
        functions.wait(0.125)
    end

    return fileName
end

function functions.isYoutube(str)
    if functions.startsWith(str, "https://www.youtube.com/watch?v=") or functions.startsWith(str, "http://www.youtube.com/watch?v=") or functions.startsWith(str, "www.youtube.com/watch?v=") or functions.startsWith(str, "youtube.com/watch?v=") or functions.startsWith(str, "https://youtu.be/") or functions.startsWith(str, "http://youtu.be/") or functions.startsWith(str, "youtu.be/") then
        return true
    else
        return false
    end
end

function functions.reply(str, message)
    message.channel:send {
        content = (str),
        reference = {
            message = message,
            mention = false,
        }
    }
end

return functions