use Mix.Config

config :discography, file_reader: Discography.Support.FileMock
config :discography, http_client: Discography.Support.HttpPoisonMock
