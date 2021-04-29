# Discography

The file (`discography.txt`) contains Bob Dylan’s discography.
Our goal is to get a Trello board through interacting with the Trello API, with the albums classified in lists sorted by decade. Each album should display its year and title and show up in the list sorted by year, and in the case of same year alphabetically. Additionally, we'd like each album to have the cover art if we can fetch it from Spotify. Your solution should be able to do that from the discography file.

# Initial setup

Download dependencies. 

```bash
mix deps.get
```

## Spotify
Obtain a client id and client secret for a new app in this link:
https://developer.spotify.com/dashboard/applications

## Trello
Generate a key here:
https://trello.com/app-key
Then click on the link that generates a token manually.

## Save it
Create a .env file in the root folder.

```dotenv
export SPOTIFY_CLIENT_ID="<<client_id>>"
export SPOTIFY_CLIENT_SECRET="<<client_secret>>"
export TRELLO_API_KEY="<<trello_key>>"
export TRELLO_TOKEN="<<trello_token>>"
```

Then run `source .env` every time this is modified to load them onto your OS.

# Start the app:

```bash
iex -S mix
iex> Discography.run("https://trello.com/b/cSCGNr0r/discography")
```

# Result:
![trello board](https://github.com/2guti2/discography/blob/master/discography.png?raw=true)
