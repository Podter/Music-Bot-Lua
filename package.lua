  return {
    name = "Podter/Music-Bot-Lua",
    version = "0.0.1",
    description = "A Discord Music Bot written in Lua",
    tags = { "lua", "lit", "luvit" },
    license = ".",
    author = { name = "Podter", email = "." },
    homepage = "https://github.com/Podter/Music-Bot-Lua",
    dependencies = {
      "SinisterRectus/discordia",
      "creationix/coro-spawn",
      "creationix/coro-split",
    },
    files = {
      "**.lua",
      "!test*"
    }
  }
  