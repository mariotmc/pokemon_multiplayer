# Pokemon Co-op

A Rails application that allows multiple users to control a Pokemon game simultaneously through a Game Boy interface.

<br>

## Prerequisites

- Ruby 3.2.1
- PostgreSQL
- [mGBA Emulator](https://mgba.io/downloads.html)
- [mGBA-http](https://github.com/nikouu/mGBA-http/releases) files
- ngrok

<br>

## Setup

```
bundle install
rails db:create db:migrate
```

1. Download and setup mGBA-http:

   - Download mGBA emulator
   - Download files from [mGBA-http releases](https://github.com/nikouu/mGBA-http/releases)
   - Place files in your preferred location

<br>

2. Start the services:

   - Start mGBA-http executable
   - Launch mGBA with your Pokemon ROM
   - Load script: Tools > Scripting > File > Load script > mGBASocketServer.lua
   - Forward port 5000 with `ngrok http 5000`
   - Set the forwarded URL as MGBA_NGROK_URL in your environment

<br>

3. Start the Rails server:

   - `bin/dev`

<br>

## Play

1. Go to `http://localhost:3000/`
2. Enter a player name
3. Press gameboy buttons to initiate game actions on your mGBA instance

## Production

If you're on the free ngrok tier, you will have to keep updating the url provided by ngrok.
The current approach (not ideal) is to set the `export MGBA_NGROK_URL=<url>` and run `kamal deploy`

<br>

## Credits

- [@nikouu's mGBA-http](https://github.com/nikouu/mGBA-http)
- Game Boy CSS (slightly modified) [@brundolf's CodePen](https://codepen.io/brundolf/pen/beagbQ)
